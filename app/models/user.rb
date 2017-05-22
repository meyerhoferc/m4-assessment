class User < ApplicationRecord
  has_secure_password
  
  has_many :links
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
