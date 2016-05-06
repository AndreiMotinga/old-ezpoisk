require "aws"

namespace :sitemap do
  desc "Upload the sitemap files to S3"
  task upload_to_s3: :environment do
    puts "Starting sitemap upload to S3..."

    s3 = AWS::S3.new(access_key_id: ENV["AWS_ACCESS_KEY_ID"],
                     secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"])

    bucket = s3.buckets[ENV["S3_BUCKET_NAME"]]

    Dir.entries(File.join(Rails.root, "tmp", "sitemaps")).each do |file_name|
      next if ['.', '..', '.DS_Store'].include? file_name
      path = "sitemaps/#{file_name}"
      file = File.join(Rails.root, "tmp", "sitemaps", file_name)

      begin
        object = bucket.objects[path]
        object.write(file: file, acl: :public_read)
      rescue => e
        raise e
      end
      puts "Saved #{file_name} to S3"
    end
  end

  desc 'Create the sitemap, then upload it to S3 and ping the search engines'
  task create_upload_and_ping: :environment do
    Rake::Task["sitemap:create"].invoke

    Rake::Task["sitemap:upload_to_s3"].invoke

    url = "https://www.ezpoisk.com/sitemaps/sitemap.xml.gz"
    SitemapGenerator::Sitemap.ping_search_engines(url)
  end
end
