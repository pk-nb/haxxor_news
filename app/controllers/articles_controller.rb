class ArticlesController < ApplicationController
  helper_method :page, :total_pages, :offset
  before_action :require_logged_in, only: [:new, :create]

  def index
    @articles = Article.offset(offset).limit(Article::PER_PAGE).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = session[:user_id]
    if @article.save
      redirect_to :articles
    else
      flash.now[:error] = 'Article was not posted—please correct fields below.'
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :url)
  end

  def page
    @page ||= [1, params[:page_number].to_i].max
  end

  def total_pages
    @total_pages = (Float(Article.count) / Float(Article::PER_PAGE)).ceil
  end

  def offset
    (page - 1) * Article::PER_PAGE
  end

  def require_logged_in
    if !logged_in?
      flash[:notice] = 'You must be logged in to post'
      redirect_to login_path
    end
  end
end
