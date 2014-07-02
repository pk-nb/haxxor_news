require 'spec_helper'

RSpec.describe 'Comments and commenting: ' do
  describe 'a logged in user' do
    before do
      valid_log_in
    end

    context 'on the home page' do
      before do
        article = create :article
        create_list :comment, 5, article: article
        visit '/'
      end

      it 'should see the number of comments a post has in link' do
        expect(page).to have_content('comments (5)')
      end

    end

    context 'viewing comments on first article' do
      before do
        articles = create_list :article, 2
        create_list :comment, 5, article: articles.last
        visit '/'
      end

      it 'should see new comment form with no other articles' do
        click_on 'comments (0)'
        expect(page).to have_field('Comment')
      end

      it 'should see existing comments and new comment form with existing articles' do
        click_on 'comments (5)'
        expect(page).to have_content('Zee comment')
      end
    end

  end
end
