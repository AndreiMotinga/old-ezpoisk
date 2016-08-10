# notifies user of new comments on listsings
class CommentMailer < ApplicationMailer
  def new_comment(comment, email)
    @comment = comment
    mail to: email,
         subject: "eZpoisk - новый коментарий под:  #{@comment.commentable.title}"
  end
end
