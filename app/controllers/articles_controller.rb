class ArticlesController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def new
    @user = current_user
    @article = Article.new
    @headers = ["What's on your mind?", "What's new?"]
  end

  def create
    @user = current_user
    @article = Article.new(article_params)
    @article.user = @user

    if @article.save
      redirect_to user_article_path(id: @article, user_id: @user)
      flash[:notice] = "Your new article has posted!"
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'Article was successfully updated!'
      # render :show
    else
      render :edit
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    if @article.destroy
      redirect_to user_articles_path, notice: 'The article has been deleted'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
