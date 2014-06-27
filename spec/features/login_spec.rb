require 'spec_helper'

RSpec.describe 'Login page' do
  let(:error_message) { 'The login and password combination is not valid' }

  describe 'a user' do
    context 'filling in the login page' do

      before do
        visit '/'
        click_on 'Login'
      end

      it 'should show error with no input' do
        within('form.new_session') { click_on 'Login' }
        expect(page).to have_content(error_message)
      end

      it 'should show error with invalid input' do
        fill_log_in_form('bad', 'params')
        expect(page).to have_content(error_message)
      end

      context 'logging in to a existing account' do
        let!(:user) { create(:user) }

        it 'successfully with username/password combination' do
          fill_log_in_form(user.username, user.password)
          expect(page).to_not have_content(error_message)
          expect(page).to have_content(user.username)
        end

        it 'successfully with email/password combination' do
          fill_log_in_form(user.email, user.password)
          expect(page).to_not have_content(error_message)
          expect(page).to have_content(user.username)
        end
      end

      context 'a logged in user' do
        let!(:user) { create(:user) }

        before do
          fill_log_in_form(user.username, user.password)
        end

        it 'can successfully logout' do
          expect(page).to have_content('user')
          expect(page).to_not have_content('Login')
          click_on 'Logout'
          expect(page).to_not have_content('user')
          expect(page).to have_content('Login')
        end
      end
    end
  end

  describe 'a new user' do
    before do
      visit '/'
      click_on 'Sign Up'
      fill_new_user_form('user', 'test@email.com', 'password', 'password')
      click_on 'Create User'
    end

    it 'should be logged in when new account is created' do
      expect(page).to have_content('user')
      expect(page).to have_link('Logout')
    end
  end
end
