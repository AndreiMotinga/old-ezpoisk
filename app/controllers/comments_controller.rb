# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    SlackNotifierJob.perform_async(@comment.id, "Comment")
    render "create.js.erb"
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :text,
                                   :parent_id)
  end
end
