class VotesController < ApplicationController
  respond_to :json
  skip_before_action :store_redirect_url

  def upvote
    render json: vote_response(1)
  end

  def downvote
    render json: vote_response(-1)
  end

  private
  def vote_response(direction)
    vote_status = toggle_vote(direction)
    {
      vote: vote_status,
      newScore: vote_status == :not_logged_in ? nil : votable.score
    }
  end

  def toggle_vote(direction)
    if logged_in?
      vote = Vote.find_or_create_by(votable: votable, user_id: current_user.id)
      if vote.direction == direction
        vote.destroy
        :destroyed
      else
        vote.update_attributes(direction: direction)
        direction == 1 ? :upvoted : :downvoted
      end
    else
      :not_logged_in
    end
  end

  def votable
    @votable ||= if params[:article_id]
      Article.find(params[:article_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end

end
