class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, length: { minimum: 4 }, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
end
