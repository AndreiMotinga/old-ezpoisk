class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    commentable = commentable_type.constantize.find(commentable_id)
    @comment = Comment.build_from(commentable, current_user.id, body)
    @comment.save
    @new_comment = Comment.build_from(@comment.commentable, current_user.id, "")
    make_child_comment
    NotifyAuthorOfCommentJob.perform_async(@comment.id)
    SlackNotifierJob.perform_async(@comment.id, "Comment")
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id)
  end

  def commentable_type
    comment_params[:commentable_type]
  end

  def commentable_id
    comment_params[:commentable_id]
  end

  def comment_id
    comment_params[:comment_id]
  end

  def body
    comment_params[:body]
  end

  def make_child_comment
    return if comment_id.blank?

    parent_comment = Comment.find comment_id
    @comment.move_to_child_of(parent_comment)
  end
end
