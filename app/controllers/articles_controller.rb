class ArticlesController < ApplicationController
  helper_method :page, :total_pages

  def index
    @articles = Article.offset(offset).limit(Article::PER_PAGE).order(created_at: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
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
    @page ||= [0, params[:page_number].to_i].max
  end

  def total_pages
    @total_pages = Article.count / Article::PER_PAGE
  end

  def offset
    page * Article::PER_PAGE
  end

end
