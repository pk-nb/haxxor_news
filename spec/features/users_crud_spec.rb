require 'spec_helper'

RSpec.describe 'User CRUD' do
  describe 'a user on the sign up page' do
    before do
      visit '/'
      click_on 'Sign Up'
    end

    it 'shows error with no input' do
      click_on 'Create User'
      expect(page).to have_css('#error')
    end

    it 'shows error with invalid input' do
      fill_in 'Username', with: 'ma'
      fill_in 'Email', with: 'creepy@marshmallow'
      fill_in 'user_password', with: 'secreteating'
      fill_in 'user_password_confirmation', with: 'secreteating'
      click_on 'Create User'
      expect(page).to have_css('#error')
    end

    it 'successfully signing up with valid input' do
      fill_in 'Username', with: 'marshie'
      fill_in 'Email', with: 'creepy@marshmallow.com'
      fill_in 'user_password', with: 'secreteating'
      fill_in 'user_password_confirmation', with: 'secreteating'

      expect {
        click_on 'Create User'
      }.to change(User, :count).by(1)

      expect(page).to_not have_css('#error')
    end
  end
end
