class SitemapController < ApplicationController
  def show
    url = "https://s3.amazonaws.com/ezpoisk/sitemaps/sitemap.xml.gz"
    data = open(url)
    send_data data.read, type: data.content_type
  end

  def show_id
    sitemap = "sitemap"
    sitemap += params[:id].to_i.to_s if params[:id]
    url = "https://s3.amazonaws.com/ezpoisk/sitemaps/#{sitemap}.xml.gz"
    data = open(url)
    send_data data.read, type: data.content_type
  end
end
