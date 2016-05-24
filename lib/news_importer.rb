# imports news from Yander Rss Feed
# frozen_string_literal: true
class NewsImporter
  USER_ID = 181 # ez

  def self.import
    NEWS_CATEGORIES.each do |link|
      xml = Nokogiri::XML(open(link))
      create_post(xml)
    end
  end

  def self.create_post(xml)
    xml.xpath("//item").each do |item|
      Post.create(user_id: @user_id,
                  title: item.at("title").text,
                  link: convert_link(item.at("link").text),
                  text: item.at("description").text,
                  visible: false,
                  created_at: item.at("pubDate").text)
    end
  end

  def self.convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    URI.decode(url)
  end
end
