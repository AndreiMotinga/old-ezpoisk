class NotifyAuthorOfCommentJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    @comment = Comment.find(id)
    return if user_commented_on_own_listsing?
    CommentMailer.new_comment(@comment).deliver_now
  end

  def user_commented_on_own_listsing?
    @comment.commentable.user == @comment.user
  end
end
