class NewsImporter
  def initialize
    @user_id = 4 # Yandex user
  end

  def import
    NEWS_CATEGORIES.each_pair do |category, links|
      links.each do |link|
        xml = Nokogiri::XML(open(link))
        create_post(xml, category)
      end
    end
  end

  def create_post(xml, category)
    xml.xpath("//item").each do |item|
      Post.create(user_id: @user_id,
                  category: category,
                  title: item.at("title").text,
                  link: convert_link(item.at("link").text),
                  description: item.at("description").text,
                  created_at: item.at("pubDate").text)
    end
  end

  def convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    URI.decode(url)
  end
end
