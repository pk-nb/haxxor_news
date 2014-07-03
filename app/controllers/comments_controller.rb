class CommentsController < ApplicationController
  skip_before_action :store_redirect_url
  before_action :require_logged_in, only: [:create]
  before_action :assign_parent, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params.merge(commentable: @parent))
    if @comment.save
      redirect_to redirect_url || :articles
    else
      flash[:error] = 'Your comment was not posted — it cannot be empty'
      redirect_to redirect_url
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id, :parent_id)
  end

  def assign_parent
    if params[:article_id]
      @parent = Article.find(params[:article_id])
    else params[:comment_id]
      @parent = Comment.find(params[:comment_id])
    end
    redirect_to redirect_url unless @parent
  end

end
