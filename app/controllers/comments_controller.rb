class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: "Commented successfully."
    else
      redirect_to @article, alert: "Something went please try again."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if @comment.user == current_user

    redirect_to @comment.article, notice: "Comment deleted successfully."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
