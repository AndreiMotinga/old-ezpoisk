class NewsImporterJob
  include Sidekiq::Worker

  def perform
    NewsImporter.new.import
    Ez.ping("import done!")
  end
end
