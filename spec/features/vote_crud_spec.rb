require 'spec_helper'

RSpec.describe 'Voting: ' do

  describe 'a logged in user' do
    before do
      valid_log_in
    end

    describe 'voting on articles' do
      before do
        article = create :article
        user = create :user
        create_list :vote, 5, votable: article, direction: 1, user_id: user.id
        visit '/'
      end

      it 'should see the current count' do
        expect(page).to have_content(5)
      end

      it 'should be able to upvote' do

      end

      it 'should be able to downvote' do

      end

      it 'should be able to remove vote' do

      end
    end
  end
end
