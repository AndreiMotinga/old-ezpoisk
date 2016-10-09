class SocialTagCreatorJob
  include Sidekiq::Worker

  def perform(id, model)
    @record = model.constantize.find_by_id(id)
    SocialTagCreator.create_tags(@record)
  end
end
