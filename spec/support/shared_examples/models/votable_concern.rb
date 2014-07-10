shared_examples 'a votable object' do
  describe '#score' do
    let!(:votable_object) { create type }
    let!(:user) { create :user }

    before do
      create_list :vote, 20, user_id: user.id, votable: votable_object, direction: 1
    end

    it 'should return the correct score with 20 upvotes' do
      expect(votable_object.score).to eq(20)
    end

    it 'should return the right score with 20 upvotes and 5 downvotes' do
      create_list :vote, 5, user_id: user.id, votable: votable_object, direction: -1
      expect(votable_object.score).to eq(15)
    end
  end
end
