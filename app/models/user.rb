class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_secure_password

  validates :email, presence: true, uniqueness: true

  #devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :validatable
end
