class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.post_id = params[:post_id]
    comment.user_id = current_user.try(:id)
    if comment.save
      SlackNotifierJob.perform_async(comment.id, "Comment")
      AdminMailerJob.perform_async(comment.id, "Comment")
    end
    redirect_to news_path(comment.post_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
