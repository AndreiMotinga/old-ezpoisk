
doc = Nokogiri::HTML(p)
if img = doc.xpath('//img').first
    p img.attr('src')
end
