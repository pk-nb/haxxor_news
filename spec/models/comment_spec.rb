require 'spec_helper'

RSpec.describe Comment do
  it_behaves_like 'a votable object' do
    let(:type) { :comment }
  end

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }

  describe '#reply_count' do
    it 'should return the correct count of replies' do
      comment = create :comment
      create_list :comment, 4, commentable: comment
      expect(comment.reply_count).to eq(4)
    end
  end
end
