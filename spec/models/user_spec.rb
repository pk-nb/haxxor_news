require 'spec_helper'

RSpec.describe User do

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should ensure_length_of(:username).is_at_least(4) }
  it { should ensure_length_of(:username).is_at_most(32) }
  it { should ensure_length_of(:password).is_at_least(8) }
  it { should validate_confirmation_of(:password) }

  it { should allow_value('get_ready@for.com', 'the_best@fsd.dfs.co').for(:email) }
  it { should allow_value('h.+-1@test.com', 'money2$$.hi@many.sub.domains.com').for(:email) }
  it { should_not allow_value('!!@ha.com', 'one@two@three.com', 'blargh@email').for(:email) }

  it { should allow_value('goodname', '$this_is_fine$', '*$()!!whynot!!()$*').for(:username) }
  it { should_not allow_value('name@', '#nameguy').for(:username) }

  describe '#password_reset' do
    let!(:user) { create :user }

    it 'correctly updates columns' do
      user.password_reset
      expect(user.password_reset_token).to_not be_nil
      expect(user.password_reset_sent_at).to_not be_nil
    end

    it 'sends an email' do
      expect { user.password_reset }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    describe '#remove_password_reset_token' do
      it 'should remove columns correctly' do
        user.password_reset
        user.remove_password_reset_token
        expect(user.password_reset_token).to be_nil
        expect(user.password_reset_sent_at).to be_nil
      end
    end

    describe '#password_reset_expired?' do

      it 'should return false if not expired' do
        user.password_reset
        expect(user.password_reset_expired?).to be_false
      end

      it 'should return true if expired' do
        user.password_reset
        user.password_reset_sent_at = 3.hours.ago
        expect(user.password_reset_expired?).to be_true
      end
    end
  end

end
