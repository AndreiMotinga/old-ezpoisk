doc = Nokogiri::HTML(p)
if img = doc.xpath("//img").first
    p img.attr("src")
end

if img = Nokogiri::HTML(text).xpath("//img").first
  update_column(:logo_url, img.attr("src"))
end
