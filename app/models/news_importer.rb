class NewsImporter
  def initialize
    @user_id = 4 # Yandex user
  end

  def import
    NEWS_CATEGORIES.each_pair do |category, details|
      next if category == "Интересное"
      if category == "Страны"
        details.each do |country|
          xml = Nokogiri::XML(open(country.first))
          create_post(xml, category, country.last)
        end
      else
        xml = Nokogiri::XML(open(details.first))
        create_post(xml, category, details.last)
      end
    end
  end

  def create_post(xml, category, subcategory)
    xml.xpath("//item").each do |item|
      Post.create(user_id: @user_id,
                  category: category,
                  subcategory: subcategory,
                  from_rss: true,
                  title: item.at("title").text,
                  link: convert_link(item.at("link").text),
                  body: item.at("description").text,
                  created_at: item.at("pubDate").text)
    end
  end

  def convert_link(url)
    url = url.gsub("https://news.yandex.ru/yandsearch?cl4url=", "")
    url = url.gsub("https://news.yandex.ua/yandsearch?cl4url=", "")
    URI.decode(url)
  end
end
