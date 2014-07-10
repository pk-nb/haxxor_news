module PasswordResetCreateHelper
  def create_password_reset(user)
    PasswordReset.new(email: user.email)
  end

  def find_password_reset(token)
    PasswordReset.find(token)
  end
end
