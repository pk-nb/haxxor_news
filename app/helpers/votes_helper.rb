module VotesHelper
  def vote_class_for(votable)
    vote = votable.user_vote(current_user)

    if vote.present?
      vote.upvote? ? 'upvoted' : 'downvoted'
    end
  end
end
