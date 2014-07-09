require 'spec_helper'

RSpec.describe PasswordReset do
  describe 'creating' do
    it 'should not be valid with junk email' do
      expect(PasswordReset.new(email: 'junk@junk.com').valid?).to be_false
    end

    it 'should be valid with valid user email' do
      user = create :user
      expect(PasswordReset.new(email: user.email).valid?).to be_true
    end

    it 'should correctly find by token' do
      user = create :user
      user.add_reset_token
      expect(PasswordReset.find(user.password_reset_token)).to_not be_nil
    end
  end

  describe 'a valid object by #new' do
    let!(:user) { create :user }
    let!(:password_reset) { create_password_reset(user) }

    it 'creates token and sends an email' do
      expect { password_reset.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    describe '#expired?' do
      before do
        password_reset.save
      end
      it 'returns false if not expired' do
        expect(password_reset.expired?).to be_false
      end

      it 'returns true if expired' do
        password_reset.user.password_reset_sent_at = 3.hours.ago
        expect(password_reset.expired?).to be_true
      end
    end
  end

  describe 'a object by #self.find' do
    let(:new_password) { 'holyalmostbatman' }
    let!(:user) do
      create :user
    end

    let(:password_reset) do
      user.add_reset_token
      find_password_reset(user.password_reset_token)
    end

    it 'should not be valid without password' do
      expect(password_reset.valid?).to be_false
    end

    describe 'when valid with password' do
      before do
        password_reset.password = new_password
        password_reset.password_confirmation = new_password
      end

      it 'should be valid with password after find' do
        expect(password_reset.valid?).to be_true
      end

      it 'should update user with #update_user' do
        expect{ password_reset.update_user }.to change {password_reset.user.password_digest}
      end
    end
  end
end
