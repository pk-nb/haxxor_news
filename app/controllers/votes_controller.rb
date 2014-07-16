class VotesController < ApplicationController
  respond_to :json

  def upvote
    render json: { vote: toggle_vote(1), newScore: votable.score }
  end

  def downvote
    render json: { vote: toggle_vote(-1), newScore: votable.score }
  end

  private
  def toggle_vote(direction)
    @vote = Vote.find_or_create_by(votable: votable, user_id: current_user.id)
    if @vote.direction == direction
      @vote.destroy
      :destroyed
    else
      @vote.direction = direction
      @vote.save
      direction == 1 ? :upvoted : :downvoted
    end
  end

  def vote_params
    params.require(:vote).permit(:direction, :user_id, :article_id, :comment_id)
  end

  def votable
    @votable ||= if params[:article_id]
      Article.find(params[:article_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
  end

end
