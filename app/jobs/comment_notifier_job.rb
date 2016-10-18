class CommentNotifierJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    comment = Comment.find(id)
    comment.emails.each do |email|
      CommentMailer.new_comment(comment, email).deliver_now
    end
  end
end
