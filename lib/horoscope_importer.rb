class HoroscopeImporter
  def initialize
    @day_xml = Nokogiri::XML(open("http://www.hyrax.ru/cgi-bin/bn_xml.cgi"))
    @month_xml = Nokogiri::XML(open("http://hyrax.ru/cgi-bin/bn_mon_xml.cgi"))
  end

  def import
    update(@day_xml, :day_description)
    update(@month_xml, :month_description)
  end

  def update(xml, attr)
    xml.xpath("//item").each_with_index do |item, i|
      next if i == 0
      record = Horoscope.find_by(title: item.at("title").text)
      record.update_attribute(attr, item.at("description").text)
    end
  end
end
