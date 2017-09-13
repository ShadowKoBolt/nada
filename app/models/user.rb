class User < ApplicationRecord
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
               :teacher_email, :teacher_phone, :teaching_locations

    validates :email, :address_line_1, :postcode, :country, presence: true

    def save
      model.password = SecureRandom.hex if model.new_record?
      super
    end
  end
end
