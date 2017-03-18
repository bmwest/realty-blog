class ArticlesController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

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
    @user = current_user
    @article = Article.find(params[:id])
  end

  def update
    @user = current_user
    @article = Article.where(id: article_params[:id], user: current_user)
    if @article.update(article_params(@article))
      @article_params = article_params[:id]
      redirect_to article_path(@article), notice: 'Article was successfully updated'
    else
      render :edit
    end
  end

  def show
    if current_user.admin?
      @article = Article.find(params[:id])
    else
      @article = Article.find(params[:id])
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def authorize_user
    unless user_signed_in? || (current_user && current_user.admin?)
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
