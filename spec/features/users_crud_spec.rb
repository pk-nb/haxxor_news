require 'spec_helper'

RSpec.describe 'User CRUD' do
  describe '#create' do
    before do
      visit '/'
      click_on 'Sign Up'
    end

    it 'shows error with no / invalid input' do
      click_on 'Create User'
      expect(page).to have_css('#errors')
    end

    it 'sucessfully creates a new user with valid input' do
      fill_in 'Username', with: 'marshie'
      fill_in 'Email', with: 'creepy@marshmallow.com'
      fill_in 'user_password', with: 'secreteating'
      fill_in 'user_password_confirmation', with: 'secreteating'

      expect {
        click_on 'Create User'
      }.to change(User, :count).by(1)

      expect(page).to_not have_css('#errors')
    end
  end
end
