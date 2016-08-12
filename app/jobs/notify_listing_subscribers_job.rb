class NotifyListingSubscribersJob
  include Sidekiq::Worker

  def perform(id)
    return if Rails.env.development?
    @comment = Comment.find(id)
    return unless emails.any?
    emails.each do |email|
      CommentMailer.new_comment(@comment, email).deliver_now
    end
  end

  def emails
    @emails ||= Subscription.where(
      subscribable_id: @comment.commentable_id,
      subscribable_type: @comment.commentable_type
    ).map(&:user).pluck(:email)

    # remove comment author
    @emails - [@comment.user.email]
  end
end
