class VotesController < ApplicationController
  respond_to :json

  skip_before_action :store_redirect_url
  before_action :require_login, unless: :logged_in?

  def upvote
    render json: vote_response(1)
  end

  def downvote
    render json: vote_response(-1)
  end


  private

  def require_login
    render json: { vote: :not_logged_in }
  end

  def vote_response(direction)
    {
      vote:     toggle_vote(direction),
      newScore: votable.score
    }
  end

  def toggle_vote(direction)
    if vote.direction == direction
      vote.destroy and return :destroyed
    elsif vote.update_attributes(direction: direction)
      vote.upvote? ? :upvoted : :downvoted
    else
      :error
    end
  end

  def vote
    @vote ||= Vote.find_or_create_by(votable: votable, user: current_user)
  end

  def votable
    @votable ||= if params[:article_id]
      Article.find(params[:article_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    else
      :error
    end
  end
end
