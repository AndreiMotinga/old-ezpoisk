class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save
    Ez.ping("new comment #{@comment.commentable.show_url}")
    render "create.js.erb"
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :text,
                                   :user_id)
  end
end
