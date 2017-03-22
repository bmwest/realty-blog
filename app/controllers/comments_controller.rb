class CommentsController < ApplicationController
  before_action :authorize_user

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
  end

  def create
    @article = Article.find(params[:article_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.article = @article
    @comment.user = @user

    if @comment.save
      flash[:notice] = 'Comment posted successfully!'
      redirect_to article_path(@article)
    else
      flash[:notice] = @comment.errors.full_messages
      redirect_to @comment.article
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @article, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), notice: 'Comment was successfully Deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user)
  end

  def authorize_user
    unless user_signed_in? || (current_user && current_user.admin?)
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
