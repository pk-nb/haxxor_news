require 'spec_helper'

RSpec.describe 'Login page' do

  describe 'a user filling in the login form' do
    before do
      visit '/'
      click_on 'Login'
    end

    let(:error_message) { 'The login and password combination is not valid' }

    it 'should show error with no input' do
      within('form') { click_on 'Login' }
      within('#flash') { expect(page).to have_content(error_message) }
    end

    it 'should show error with invalid input' do
      fill_in 'session_login', with: 'bad@username'
      fill_in 'session_password', with: 'short'
      within('form') { click_on 'Login' }
      within('#flash') { expect(page).to have_content(error_message) }
    end

    it 'sucessfully logs in with valid username / password combination' do
      create(:user, username: 'user', password: 'password', password_confirmation: 'password')
      within('form') do
        fill_in 'Login', with: 'user'
        fill_in 'session_password', with: 'password'
        click_on 'Login'
      end
      within('#flash') { expect(page).to_not have_content(error_message) }
      expect(page).to have_content('user')
    end

    it 'successfully logs in with valid email / password combination' do
      create(:user, username: 'user', email: 'valid@email.com', password: 'password', password_confirmation: 'password')
      within('form') do
        fill_in 'session_login', with: 'valid@email.com'
        fill_in 'session_password', with: 'password'
        click_on 'Login'
      end
      within('#flash') { expect(page).to_not have_content(error_message) }
      expect(page).to have_content('user')
    end
  end


  def valid_login
    visit '/'
    click_on 'Login'
    create(:user, username: 'user', password: 'password', password_confirmation: 'password')
    within('form') do
      fill_in 'session_login', with: 'user'
      fill_in 'session_password', with: 'password'
      click_on 'Login'
    end
  end


  describe 'login related links visable to the user' do
    it 'should show login link when not logged in' do
      visit '/'
      expect(page).to have_link('Login')
    end

    it 'should show username and logout links when logged in' do
      valid_login
      expect(page).to have_content('user')
      expect(page).to have_link('Logout')
    end
  end


  describe 'a logged in user' do
    before do
      valid_login
    end

    it 'should allow a logged in user to successfully logout' do
      click_on 'Logout'
      expect(page).to_not have_content('user')
      expect(page).to have_content('Login')
    end
  end

  describe 'a new user' do
    before do
      visit '/'
      click_on 'Sign Up'
      fill_in 'Username', with: 'user'
      fill_in 'Email', with: 'user@test.com'
      fill_in 'user_password', with: 'testtest'
      fill_in 'user_password_confirmation', with: 'testtest'
      click_on 'Create User'
    end

    it 'should be logged in when new account is created' do
      expect(page).to have_content('user')
      expect(page).to have_link('Logout')
    end
  end
end
