require "spec_helper"

describe UserMailer do

  describe '#password_reset' do
    context 'mail correctly generated' do
      let! (:user) { create :user }
      let! (:password_reset) { create_password_reset(user) }
      let! (:mail) do
        password_reset.save
        user.reload
        UserMailer.password_reset(user)
      end

      it 'renders the correct subject' do
        expect(mail.subject).to eq('Reset Password - HaxxorNews')
      end

      it 'sends to the correct user email' do
        expect(mail.to).to eq([user.email])
      end

      it 'sends from the correct address' do
        expect(mail.from).to eq(['notifications@viget-hn.herokuapp.com'])
      end

      it 'html version contains the correct link' do
        expect(mail.body.encoded).to include("localhost:3000/reset/#{user.password_reset_token}")
      end
    end
  end
end
