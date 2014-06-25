require 'spec_helper'

RSpec.describe 'User CRUD' do
  describe 'a user on the sign up page' do
    before do
      visit '/'
      click_on 'Sign Up'
    end

    let(:error_message) { 'Was unsuccessful registering' }

    it 'shows error with no input' do
      click_on 'Create User'
      within('#flash') { expect(page).to have_content(error_message) }
    end

    it 'shows error with invalid input' do
      fill_new_user_form('m', 'bad@email', 'password', 'password')
      click_on 'Create User'
      within('#flash') { expect(page).to have_content(error_message) }
    end

    it 'successfully signing up with valid input' do
      fill_new_user_form('marshie', 'creepy@marshmallow.com', 'secreteating', 'secreteating')

      expect {
        click_on 'Create User'
      }.to change(User, :count).by(1)

      within('#flash') { expect(page).to_not have_content(error_message) }
    end
  end
end
