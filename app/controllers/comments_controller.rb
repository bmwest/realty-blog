class CommentsController < ApplicationController

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
  end

  def create
    @article = Article.find(params[:article_id])
    if current_user
      @user = current_user
      @comment = Comment.new(comment_params)
      @comment.article = @article
      @comment.user = @user
    else
      @comment = Comment.new(comment_params)
      @comment.article = @article
    end

    if @comment.save
      flash[:notice] = 'Comment posted successfully!'
      redirect_to article_path(@article)
    else
      @comment.errors.full_messages.each do |er|
        flash[:notice] = er
      end
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
    params.require(:comment).permit(:body, :user, :commenter)
  end

  def authorize_user
    unless user_signed_in? || (current_user && current_user.admin?)
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
