class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    email_validation = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, uniqueness: true, format: { with: email_validation }
    password_validation = /\A[a-zA-Z0-9]+\z/
    validates :password, confirmation: true, format: { with: password_validation }
    validates :password_confirmation
    name_validation = /\A[ぁ-んァ-ン一-龥]/
    validates :last_name, format: { with: name_validation }
    validates :first_name, format: { with: name_validation }
    name_reading_validation = /\A[ァ-ヶー－]+\z/
    validates :last_name_reading, format: { with: name_reading_validation }
    validates :first_name_reading, format: { with: name_reading_validation }
    validates :birthday
  end
end
