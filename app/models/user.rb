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

  def name
    [first_name, last_name].join(' ')
  end

  class AdminForm < Reform::Form
    model :user
    properties :email, :phone, :first_name, :last_name,
               :address_line_1, :address_line_2, :address_line_3,
               :city, :region, :postcode, :country, :notes, :teacher,
               :teacher_email, :teacher_phone, :teaching_locations, :join_date,
               :renewal_date, :status

    validates :email, :address_line_1, :postcode, :country, presence: true

    def save
      model.password = SecureRandom.hex if model.new_record?
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
      model.status = 'New'
      super
    end
  end

  class MyAccountForm < Reform::Form
    model :user
    properties :email, :phone, :first_name, :last_name,
               :address_line_1, :address_line_2, :address_line_3,
               :city, :region, :postcode, :country, :password, :password_confirmation
    property :current_password, virtual: true

    validates :email, :address_line_1, :postcode, :country, presence: true
    validates :password, length: { minimum: 6 }, if: Proc.new { |u| u.password.present? }
    validates_uniqueness_of :email
    validate do
      errors.add(:password_confirmation, 'does not match password') if password != password_confirmation
      errors.add(:current_password, 'is incorrect.  We need to check your current password to ensure you are authorized to make changes.') unless model.valid_password?(current_password)
    end

    def save
      model.status = 'New'
      super
    end
  end
end
