class SitemapController < ApplicationController
  def show
    data = open("https://s3.amazonaws.com/#{ENV['S3_BUCKET_NAME']}/sitemaps/sitemap#{params[:id]}.xml.gz")
    send_data data.read, :type => data.content_type
  end
end
