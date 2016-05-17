class HoroscopeImporter
  DAY_XML_URL = "http://www.hyrax.ru/cgi-bin/bn_xml.cgi".freeze
  MONTH_XML_URL = "http://hyrax.ru/cgi-bin/bn_mon_xml.cgi".freeze

  def initialize
    @day_xml = Nokogiri::XML(open(DAY_XML_URL))
    @month_xml = Nokogiri::XML(open(MONTH_XML_URL))
  end

  def import
    update(@day_xml, :day_description)
    update(@month_xml, :month_description)
  end

  # todo extract to another class and to the same for abother importer
  def update(xml, attr)
    xml.xpath("//item").each_with_index do |item, i|
      next if i == 0
      record = Horoscope.find_by(title: item.at("title").text)
      record.update_attribute(attr, item.at("description").text)
    end
  end
end
