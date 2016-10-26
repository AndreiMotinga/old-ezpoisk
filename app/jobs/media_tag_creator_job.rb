class MediaTagCreatorJob
  include Sidekiq::Worker

  def perform(id, model)
    @record = model.constantize.find_by_id(id)
    Media::TagCreator.create_tags(@record)
  end
end
