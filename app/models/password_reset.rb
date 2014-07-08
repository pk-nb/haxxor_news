class PasswordReset
  include ActiveModel::Model
  attr_accessor :email, :password
  validates :email, email: true, if: 'password.nil?'
  validates :password, length: { minimum: 8 }, confirmation: true, if: 'email.nil?'


  def update_user(user)
    if user.update_attributes(password: password, password_confirmation: password_confirmation)
      user.remove_password_reset_token
      true
    else
      false
    end
  end
end
