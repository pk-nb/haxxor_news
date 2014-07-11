class VotesController < ApplicationController
  respond_to :json
  before_action :assign_parent

  def create
    @vote = Vote.new(votable: @parent, user_id: current_user.id, direction: params[:direction])
    if @vote.save
      render json: {vote: @vote,
                    method: :create,
                    newScore: @parent.score,
                    newLink: @vote.url }
    else
      render json: @vote.errors, status: :error
    end
  end

  def destroy
    @vote = Vote.where(votable: @parent, user_id: current_user.id).first # parent stuff)
    if @vote.destroy
      render json: {vote: @vote, method: :destroy, newScore: @parent.score}
    else
      render json: @vote.errors, status: :error
    end
  end

  def update

  end

  private
  def vote_params
    params.require(:vote).permit(:direction, :user_id, :article_id, :comment_id)
  end

  def assign_parent
    @parent = if params[:article_id]
      Article.find(params[:article_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    end
    # redirect_to redirect_url unless @parent
  end

end
