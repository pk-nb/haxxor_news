require 'spec_helper'

RSpec.describe 'Comments and commenting: ' do
  describe 'a logged in user' do
    before do
      valid_log_in
    end

    context 'on the home page' do
      before do
        article = create :article
        create_list :comment, 5, commentable: article
        visit '/'
      end

      it 'should see the number of comments a post has in link' do
        expect(page).to have_content('comments (5)')
      end

    end

    context 'viewing comments' do
      let(:existing_comment_text) { 'frist!11' }

      before do
        articles = create_list :article, 2
        create_list :comment, 5, body: existing_comment_text, commentable: articles.last
        visit '/'
      end

      it 'should see new comment form with no other articles' do
        click_on 'comments (0)'
        expect(page).to have_field('comment[body]')
      end

      it 'should see existing comments and new comment form with existing articles' do
        click_on 'comments (5)'
        expect(page).to have_content(existing_comment_text)
      end

      context 'commenting on an article' do
        let(:comment_text) { 'This article made me cry' }

        context 'with no other comments' do
          before do
            click_on 'comments (0)'
            fill_in 'comment[body]', with: comment_text
            click_on 'Post Comment'
          end

          it 'should show submitted comment' do
            expect(page).to have_content comment_text
          end

          it 'should show an updated count on the articles page' do
            visit '/'
            expect(page).to have_content 'comments (1)'
          end
        end

        context 'replying to another comment' do
          before do
            click_on 'comments (5)'
            within('.comment:first-child') do
              fill_in 'comment[body]', with: comment_text
              click_on 'Post Reply'
            end
          end

          it 'should show reply' do
            expect(page).to have_content comment_text
          end

          it 'should show an updated count on the articles page' do
            visit '/'
            expect(page).to have_content 'comments (6)'
          end
        end
      end

    end
  end
end
