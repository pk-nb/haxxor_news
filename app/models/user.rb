class User < ActiveRecord::Base
  has_secure_password

  # Disallow the '@' character to avoid email name conflicts
  illegal_chars = /\A[^@]+\z/

  validates :username, presence: true, length: { minimum: 4 }, uniqueness: { case_sensitive: false }, format: { with: illegal_chars }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 8 }
end
