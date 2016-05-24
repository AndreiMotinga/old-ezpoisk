class NewsImporterJob
  include Sidekiq::Worker

  def perform
    NewsImporter.import
    Ez.ping("import done!")
  end
end
