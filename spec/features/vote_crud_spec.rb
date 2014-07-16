require 'spec_helper'

RSpec.describe 'Voting: ' do

  describe 'a logged in user', js: true do
    before do
      valid_log_in
    end

    describe 'voting on articles' do
      before do
        article = create :article
        create_list :vote, 5, votable: article, direction: 1
        visit '/'
      end

      it 'should see the current count' do
        expect(page).to have_content(5)
      end

      it 'should be able to upvote' do
        page.find('.up.vote').click
        expect(page).to have_content(6)
      end

      it 'should be able to downvote' do
        page.find('.down.vote').click
        expect(page).to have_content(4)
      end
    end
  end
end
