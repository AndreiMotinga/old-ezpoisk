class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    post_id = params[:post_id]
    comment.post_id = post_id
    comment.user_id = current_user.id
    comment.save
    redirect_to news_path(post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
