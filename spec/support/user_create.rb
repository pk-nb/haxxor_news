module UserCreateHelper
  def fill_new_user_form(username, email, password, password_confirmation)
    within('form.new_user') do
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password_confirmation
    end
  end
end
