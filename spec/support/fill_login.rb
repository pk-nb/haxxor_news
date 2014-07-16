module FillLoginHelper
  def fill_log_in_form(login, password)
    within('form.new_session') do
      fill_in 'Login', with: login
      fill_in 'Password', with: password
      click_on 'Login'
    end
  end

  def log_in(login, password)
    visit '/'
    click_on 'login'
    fill_log_in_form(login, password)
  end

  def valid_log_in
    user = create :user
    log_in(user.username, user.password)
  end
end
