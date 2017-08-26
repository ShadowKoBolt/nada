class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :rememberable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
end
