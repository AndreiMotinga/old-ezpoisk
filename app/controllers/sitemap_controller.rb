# frozen_string_literal: true

class SitemapController < ApplicationController
  def show
    url = "https://s3.amazonaws.com/ezpoisk/sitemaps/sitemap.xml.gz"
    data = open(url)
    send_data data.read, type: data.content_type
  end

  def show_id
    url = "https://s3.amazonaws.com/ezpoisk/sitemaps/#{sitemap}.xml.gz"
    data = open(url)
    send_data data.read, type: data.content_type
  end

  private

  def sitemap
    param = params[:id].to_i
    id = (0..param).to_a.find { |num| num == param }
    "sitemap#{id}"
  end
end
