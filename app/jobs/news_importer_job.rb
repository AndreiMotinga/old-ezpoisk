class NewsImporterJob
  include Sidekiq::Worker

  def perform
    # todo make import class method
    NewsImporter.new.import
    Ez.ping("import done!")
  end
end
