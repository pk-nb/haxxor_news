class User < ActiveRecord::Base
  has_secure_password

  has_many :articles
  has_many :comments

  # Disallow the '@' character to avoid email name conflicts
  legal_chars = /\A[^@]+\z/

  validates :username, presence: true, length: { in: 4..32 }, uniqueness: { case_sensitive: false }, format: { with: legal_chars }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 8 }
end
