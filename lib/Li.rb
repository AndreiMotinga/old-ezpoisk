class Li
  attr_reader :link, :url

  def self.import(link)
    new(link).import
  end

  def initialize(link)
    @link = link
    @url = "https://svoi.us#{link.source}"
  end

  def import
    doc = Nokogiri::HTML(open(url))
    title = doc.css("h1.promo-companies__desk-line1").text
    category = doc.css("p.promo-companies__desk-line2").text.strip
    desc = doc.css("div.t-descr_xxs").first.css("p").text

    tags = doc.css("div.t-descr_xxs")[1].css("a")
    phones = doc.css(".t-phones a")
    contacts = (tags + phones).map {|contact| [contact['href'], contact['title']] }

    phone = contacts.select{|con| con[1] == "Телефон" }&.flatten&.first
    site = contacts.select{|con| con[1] == "Сайт" }&.flatten&.first
    email = contacts.select{|con| con[1] == "E-mail" }&.flatten&.first
    subs = contacts.map {|con| con[1]}.reject{ |word| %w(Телефон E-mail Сайт).include? word }.join(",")

    address = doc.css("script")[7]&.text
    pictures = doc.css(".photos-subdiv a").map {|pic| pic['href']}.join(",")

    link.update({
      title: title,
      category: category,
      description: desc,
      phone: phone,
      site: site,
      email: email,
      subs: subs,
      address: address,
      pictures: pictures
    })
  end
end
