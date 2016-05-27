# imports news from Yander Rss Feed
# frozen_string_literal: true
class NewsImporter
  USER_ID = 181 # ez

  def self.import
    @records = []
    NEWS_CATEGORIES.each do |link|
      xml = Nokogiri::XML(open(link))
      parse_posts(xml)
    end
    create_posts
  end

  private_class_method

  def self.parse_posts(xml)
    xml.xpath("//item").each do |item|
      @records << [formatted_record(item)]
    end
  end

  def self.formatted_record(item)
    <<-EOL
      ('#{USER_ID}',
      '#{item.at('title').text}',
      '#{convert_link(item.at('link').text)}',
      '#{item.at('description').text}',
      '#{false}',
      '#{item.at('pubDate').text}',
      '#{Time.current}')
    EOL
  end

  def self.create_posts
    sql = <<-EOL
      INSERT INTO posts (
        user_id, title, link, text, visible, created_at,updated_at
      )
      VALUES #{@records.join(', ')}
    EOL
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    URI.decode(url)
  end
end
