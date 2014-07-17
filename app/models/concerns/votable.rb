module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def score
    votes.sum(:direction)
  end

  def user_vote(user)
    user.present? ? self.votes.where(user_id: user.id).first : nil
  end
end
