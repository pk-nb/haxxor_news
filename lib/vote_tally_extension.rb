module VoteTallyExtension
  def vote_tally
    inject {|sum, vote| sum += vote.direction }
  end
end
