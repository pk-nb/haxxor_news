require 'spec_helper'

describe Vote do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :votable_id }
  it { should validate_presence_of :votable_type }
  it { should ensure_inclusion_of(:direction).in_array [-1, 1] }

  describe 'validate uniqueness with scope' do
    let!(:user) { create :user }
    let!(:article) { create :article }

    it 'should disallow non-unique users on votable items' do
      createVote = -> { Vote.create(user_id: user.id, votable: article, direction: 1) }
      expect{ createVote.call }.to change{ Vote.count }.by(1)
      expect{ createVote.call }.to_not change{ Vote.count }.by(1)
    end
  end
end
