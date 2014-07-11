module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def score
    self.votes.inject(0) { |sum, vote| sum += vote.direction }
  end

  def user_vote(user)
    self.votes.where(user_id: user.id).first
  end
end
