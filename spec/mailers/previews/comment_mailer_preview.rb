# http://localhost:3000/rails/mailers/comment/new_comment
class CommentMailerPreview < ActionMailer::Preview
  def new_comment
    return if Rails.env.production?
    CommentMailer.new_comment(Comment.last, "foo@bar")
  end
end
