module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def score
    votes.sum(:direction)
  end

  def user_vote(user)
    self.votes.where(user: user).first
  end
end
