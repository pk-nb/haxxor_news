class User < ActiveRecord::Base
  has_secure_password
  validates :username, presence: true, length: { minimum: 4 }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 8 }
end
