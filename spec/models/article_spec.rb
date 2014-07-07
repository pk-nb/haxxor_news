require 'spec_helper'

RSpec.describe Article, :type => :model do

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(255) }

  describe 'URL validation' do
    it { should allow_value('http://viget.com', 'https://viget.com').for(:url) }
    it { should allow_value('http://pk-nb.github.io', 'http://her.bs').for(:url) }

    it { should_not allow_value('afdsafdsf', 'ftp://something').for(:url) }
    it { should_not allow_value('htt://google.com', 'ftp://hi.com').for(:url) }
  end

  describe '#comment_count' do
    it 'should return the correct count of comments (including replies)' do
      article = create :article
      top_level_comments = create_list :comment, 5, commentable: article
      create_list :comment, 5, commentable: top_level_comments.first
      expect(article.comment_count).to eq(10)
    end
  end

end
