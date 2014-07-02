require 'spec_helper'

RSpec.describe Comment do
  describe 'a logged in user' do
    before do
      valid_log_in
    end

    context 'on the home page' do
      it 'should see the number of comments a post has in link'
    end

    context 'viewing comments on first article' do
      it 'should see new comment form with no other articles'
      it 'should see existing comments and new comment form with existing articles'
    end

  end
end
