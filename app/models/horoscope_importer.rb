class HoroscopeImporter
  def initialize
    @day_xml = Nokogiri::XML(open("http://www.hyrax.ru/cgi-bin/bn_xml.cgi"))
    @month_xml = Nokogiri::XML(open("http://hyrax.ru/cgi-bin/bn_mon_xml.cgi"))
  end

  def import
    update_days
    update_months
  end

  def update_days
    @day_xml.xpath("//item").each_with_index do |item, i|
      next if i == 0
      record = Horoscope.find_or_create_by(title: item.at("title").text)
      record.day_description = item.at("description").text
      record.save
    end
  end

  def update_months
    @month_xml.xpath("//item").each do |item|
      record = Horoscope.find_or_create_by(title: item.at("title").text)
      record.month_description = item.at("description").text
      record.save
    end
  end
end
