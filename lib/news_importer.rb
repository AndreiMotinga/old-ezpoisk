# frozen_string_literal: true
require "rss"

# imports news
class NewsImporter
  USER_ID = 181 # ez

  def self.import
    @records = []
    import_data
    create_posts
  end

  private_class_method

  def self.import_data
    self.links.each do |arr|
      url = arr[0]
      category = arr[1]
      rss = RSS::Parser.parse(url, false)
      next if rss.nil?
      format_rss(rss, category)
    end
  end

  def self.format_rss(rss, category)
    rss.items.map { |item| @records << [format(item, category)] }
  end

  def self.format(item, category)
    <<-EOL
      ('#{USER_ID}',
       '#{item.title.gsub("'", "''")}',
       '#{item.description.try(:gsub, "'", "''")}',
       '#{convert_link(item.link)}',
       '#{category}',
       '#{false}',
       '#{item.pubDate}',
       '#{Time.current}')
    EOL
  end

  def self.create_posts
    sql = <<-EOL
      INSERT INTO posts (
        user_id, title, summary, link, category, visible, created_at, updated_at
      )
      VALUES #{@records.join(', ')}
    EOL
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    url = url.gsub("http://www.cnn.com", "http://edition.cnn.com/")
    URI.decode(url)
  end

  def self.links
    [
      ["https://news.yandex.ru/world.rss", "world"],
      ["https://news.yandex.ru/movies.rss", "entertainment"],
      ["https://news.yandex.ru/music.rss", "entertainment"],
      ["https://news.yandex.ru/science.rss", "science"],
      ["https://news.yandex.ru/computers.rss", "tech"],
      ["https://news.yandex.ru/internet.rss", "tech"],
      ["https://news.yandex.ru/USA/index.rss", "top"],

      # ["http://rss.cnn.com/rss/edition.rss", "top"],
      # ["http://rss.cnn.com/rss/edition_world.rss", "world"],
      # ["http://rss.cnn.com/rss/edition_us.rss", "us"],
      # ["http://rss.cnn.com/rss/money_news_international.rss", "money"],
      # ["http://rss.cnn.com/rss/edition_technology.rss	", "tech"],
      # ["http://rss.cnn.com/rss/edition_space.rss", "science"],
      # ["http://rss.cnn.com/rss/edition_entertainment.rss", "entertainment"],
      # ["http://rss.cnn.com/rss/edition_travel.rss", "travel"],

      ["http://feeds.abcnews.com/abcnews/topstories", "top"],
      ["http://feeds.abcnews.com/abcnews/internationalheadlines", "world"],
      ["http://feeds.abcnews.com/abcnews/usheadlines", "us"],
      ["http://feeds.abcnews.com/abcnews/moneyheadlines", "money"],
      ["http://feeds.abcnews.com/abcnews/entertainmentheadlines", "entertainment"],
      ["http://feeds.abcnews.com/abcnews/travelheadlines", "travel"],

      ["http://feeds.foxnews.com/foxnews/most-popular", "top"],
      ["http://feeds.foxnews.com/foxnews/world", "world"],
      ["http://feeds.foxnews.com/foxnews/national", "us"],
      ["http://feeds.foxnews.com/foxnews/tech", "tech"],
      ["http://feeds.foxnews.com/foxnews/science", "science"],
      ["http://feeds.foxnews.com/foxnews/entertainment", "entertainment"],
      ["http://feeds.foxnews.com/foxnews/internal/travel/mixed", "travel"],

      ["http://www.nbcnewyork.com/news/top-stories/?rss=y&embedThumb=y&summary=y", "top"],
      ["http://www.nbcnewyork.com/news/tech/?rss=y&embedThumb=y&summary=y", "tech"],
      ["http://www.nbcnewyork.com/entertainment/top-stories/?rss=y&embedThumb=y&summary=y", "entertainment"],

      ["http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml", "top"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/World.xml", "world"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/US.xml", "us"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/Business.xml", "money"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/Technology.xml", "tech"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/Science.xml", "science"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/Travel.xml", "travel"],
      ["http://rss.nytimes.com/services/xml/rss/nyt/Automobiles.xml", "autonews"],

      ["http://rssfeeds.usatoday.com/usatoday-NewsTopStories", "top"],
      ["http://rssfeeds.usatoday.com/UsatodaycomMoney-TopStories", "money"],
      ["http://rssfeeds.usatoday.com/usatoday-TechTopStories", "tech"],
      ["http://rssfeeds.usatoday.com/usatoday-LifeTopStories", "entertainment"],
      ["http://rssfeeds.usatoday.com/UsatodaycomTravel-TopStories", "travel"],

      ["http://www.wsj.com/xml/rss/3_7085.xml", "world"],
      ["http://www.wsj.com/xml/rss/3_7014.xml", "money"],
      ["http://www.wsj.com/xml/rss/3_7455.xml", "tech"],

      ["http://feeds.feedburner.com/cnet/tcoc", "tech"],
    ]
  end
end
