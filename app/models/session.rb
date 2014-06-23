class Session
  include ActiveModel::Model
  attr_accessor :login, :password

  validates :login, :password, presence: true
  validate :credentials_valid

  private
  def credentials_valid
    user = User.where("username = :login OR email = :login", {login: login }).first
    if !user || !user.authenticate(password)
      errors.add(:base, 'Credentials are invalid')
    end
  end
end
