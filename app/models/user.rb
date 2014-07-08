class User < ActiveRecord::Base
  has_secure_password

  has_many :articles
  has_many :comments

  # Disallow the '@' character to avoid email name conflicts
  legal_chars = /\A[^@]+\z/

  validates :username, presence: true, length: { in: 4..32 }, uniqueness: { case_sensitive: false }, format: { with: legal_chars }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :password, length: { minimum: 8 }

  def password_reset
    self.password_reset_token = generate_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private
  def generate_token
    SecureRandom.urlsafe_base64
  end
end
