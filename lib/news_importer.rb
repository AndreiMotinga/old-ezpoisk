class NewsImporter
  def initialize
    @user_id = 181 # ez
  end

  def import
    NEWS_CATEGORIES.each do |link|
      xml = Nokogiri::XML(open(link))
      create_post(xml)
    end
  end

  def create_post(xml)
    xml.xpath("//item").each do |item|
      Post.create(user_id: @user_id,
                  title: item.at("title").text,
                  link: convert_link(item.at("link").text),
                  text: item.at("description").text,
                  visible: false,
                  created_at: item.at("pubDate").text)
    end
  end

  def convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    URI.decode(url)
  end
end
