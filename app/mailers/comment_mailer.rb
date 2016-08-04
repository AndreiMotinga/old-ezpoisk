# notifies user of new comments on listsings
class CommentMailer < ApplicationMailer
  def new_comment(comment)
    @comment = comment
    mail to: @comment.commentable.notification_email,
         subject: "eZpoisk - #{@comment.commentable.title} - Новый Коментарий"
  end
end
