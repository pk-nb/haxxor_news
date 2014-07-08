class UserMailer < ActionMailer::Base
  default from: 'notifications@viget-hn.herokuapp.com'

  def password_reset(user)
    @user = user
    mail(to: @user.email,
         subject: 'Reset Password - HaxxorNews',
         template_path: 'mail')
  end
end
