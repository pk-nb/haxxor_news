class CommentsController < ApplicationController
  skip_before_action :store_redirect_url
  before_action :require_logged_in, only: [:create]
  before_action :assign_article, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params.merge(article: @article))

    if @comment.save
      redirect_to @article
    else
      flash.now[:error] = 'Your comment was not posted — please correct errors below'
      render 'articles/show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end

  def assign_article
    @article = Article.find(params[:article_id])
    redirect_to articles_path unless @article
  end
end
