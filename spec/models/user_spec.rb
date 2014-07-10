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

  describe 'reset tokens' do
    let!(:user) { create :user }

    it 'correctly updates columns' do
      user.add_reset_token
      expect(user.password_reset_token).to_not be_nil
      expect(user.password_reset_sent_at).to_not be_nil
    end

    describe '#remove_password_reset_token' do
      it 'should remove columns correctly' do
        user.add_reset_token
        user.remove_reset_token
        expect(user.password_reset_token).to be_nil
        expect(user.password_reset_sent_at).to be_nil
      end
    end
  end
end
