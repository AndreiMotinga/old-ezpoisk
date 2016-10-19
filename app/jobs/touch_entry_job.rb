class TouchEntryJob
  include Sidekiq::Worker

  def perform(id)
    Comment.find(id).commentable.entry.touch
  end
end
