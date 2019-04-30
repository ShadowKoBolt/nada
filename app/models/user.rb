class User < ApplicationRecord
  STATUS_OPTIONS = %w[ New Lapsed Confirmed ].freeze

  include PgSearch
  pg_search_scope :search,
    against: [:email, :first_name, :last_name],
    using: { tsearch: { prefix: true, any_word: true }, trigram: { threshold: 0.1 } }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :rememberable
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :registerable

  has_many :dance_classes, dependent: :destroy

  class << self
    def to_csv
      rejected_keys = %w[encrypted_password reset_password_token reset_password_sent_at remember_created_at]
      attributes = User.new.attributes.keys.reject { |key| key.in? rejected_keys }

      CSV.generate(headers: true) do |csv|
        csv << attributes

        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

    def status_filter_options
      [['Any status', nil], ['Lapsed (renewal date in past)', 'lapsed'], ['Active (renewal date in future)', 'active']]
    end

    def paperless_filter_options
      [['Paper & Paperless', nil], ['Paper', 'paper'], ['Paperless', 'paperless']]
    end
  end

  def name
    [first_name, last_name].join(' ')
  end

  def stripe_customer
    return nil unless stripe_customer_id?
    @stripe_customer ||= Stripe::Customer.retrieve(stripe_customer_id)
  rescue Stripe::InvalidRequestError
    nil
  end

  def stripe_subscriptions
    return [] unless stripe_customer
    @stripe_subscriptions ||= stripe_customer.subscriptions
  end

  def stripe_sources
    return [] unless stripe_customer
    stripe_customer.sources
  end

  def appropriate_plan_name
    country == 'GB' ? ENV['STRIPE_PLAN_NAME_UK'] : ENV['STRIPE_PLAN_NAME_INTERNATIONAL']
  end

  def full_street_address
    [address_line_1, address_line_2, address_line_3, city, region, postcode, country].reject(&:blank?).join(', ')
  end

  def determine_status
    return "New" if renewal_date.nil?
    return "Confirmed" if renewal_date > Date.today
    "Lapsed"
  end

  class AdminForm < Reform::Form
    model :user
    properties :email, :phone, :first_name, :last_name,
               :address_line_1, :address_line_2, :address_line_3,
               :city, :region, :postcode, :country, :notes, :teacher,
               :teacher_email, :teacher_phone, :teaching_locations, :join_date,
               :renewal_date, :status, :admin, :password,
               :password_confirmation, :paperless

    validates :email, :address_line_1, :postcode, :country, presence: true
    validates :password, :password_confirmation, presence: true, allow_blank: true
    validates :password, length: { minimum: 6, if: proc { password.present? } }
    validates :password, confirmation: { if: proc { password.present? } }
    validates_uniqueness_of :email

    def save
      if model.new_record? && password.blank? && password_confirmation.blank?
        self.password = SecureRandom.hex
      end
      super
    end
  end

  class RegistrationForm < Reform::Form
    model :user
    properties :email, :phone, :first_name, :last_name,
               :address_line_1, :address_line_2, :address_line_3,
               :city, :region, :postcode, :country, :password, :password_confirmation

    validates :email, :address_line_1, :postcode, :country, presence: true
    validates :password, :password_confirmation, presence: true
    validates :password, length: { minimum: 6 }
    validates_uniqueness_of :email
    validate do
      errors.add(:password_confirmation, 'does not match password') if password != password_confirmation
    end

    def save
      model.status = "New"
      super
    end
  end

  class MyAccountForm < Reform::Form
    model :user
    properties :email, :phone, :first_name, :last_name,
               :address_line_1, :address_line_2, :address_line_3,
               :city, :region, :postcode, :country, :password, :password_confirmation,
               :teacher, :teacher_email, :teacher_phone, :teaching_locations
    property :current_password, virtual: true

    validates :email, :address_line_1, :postcode, presence: true
    validates :password, length: { minimum: 6 }, if: proc { |u| u.password.present? }
    validates_uniqueness_of :email
    validate do
      errors.add(:password_confirmation, 'does not match password') if password != password_confirmation
      errors.add(:current_password, 'is incorrect.  We need to check your current password to ensure you are authorized to make changes.') unless model.valid_password?(current_password)
    end

    def stripe_subscriptions
      model.stripe_subscriptions
    end

    def stripe_sources
      model.stripe_sources
    end

    def save
      model.status = 'New'
      super
    end
  end
end
