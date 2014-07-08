class PasswordReset
  include ActiveModel::Model
  attr_accessor :email, :password
  validates :email, email: true, if: 'password.nil?'
  validates :password, length: { minimum: 8 }, confirmation: true, if: 'email.nil?'


  def update_user(user)
    raise 'PasswordReset#update_user not implemented'
  end
end
