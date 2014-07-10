require 'spec_helper'

RSpec.describe 'Password reset:' do

  describe 'a user who forgot password' do
    let(:nonexistant_email) { 'junk@blah.com' }
    let(:email) { 'donthaveapasswordmanager@forgetful.com' }
    let!(:user) { create :user, email: email }

    describe 'filling password reset form' do
      before do
        visit '/'
        click_on 'login'
        click_on 'Reset it here'
      end

      it 'should see reset email form' do
        expect(page).to have_field('Email')
      end

      it 'should not get any information when maliciously puts in random emails' do
        fill_in 'Email', with: nonexistant_email
        expect{ click_on 'Send Reset Email' }.to_not change { ActionMailer::Base.deliveries.count }.by(1)
        expect(page).to have_content('User not found')
      end

      it 'should have email reset with correct email' do
        fill_in 'Email', with: email
        expect{ click_on 'Send Reset Email' }.to change { ActionMailer::Base.deliveries.count }.by(1)
        expect(page).to have_content('Password reset email sent')
      end

      describe 'resetting password from reset link in email' do
        before do
          fill_in 'Email', with: email
          click_on 'Send Reset Email'
          user.reload
          visit edit_reset_path(id: user.password_reset_token)
        end

        let(:new_password) { 'supercoolpassword' }

        it 'should see password reset form' do
          expect(page).to have_field('Password')
          expect(page).to have_field('Password confirmation')
        end

        it 'should be prompted when there are form errors' do
          fill_in 'Password', with: 'newpassword'
          fill_in 'Password confirmation', with: 'notsamepassword'
          click_on 'Reset Password'
          expect(page).to have_content('Password was not updated—please correct fields below')
        end

        describe 'when password has been reset' do
          before do
            fill_in 'Password', with: new_password
            fill_in 'Password confirmation', with: new_password
            click_on 'Reset Password'
            user.reload
          end

          it 'should see password reset confirmation' do
            expect(page).to have_content('Password successfully updated')
          end

          it 'should be logged in' do
            expect(page).to have_content(user.username)
            expect(page).to have_content('logout')
          end
        end
      end
    end
  end
end
