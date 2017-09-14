class Li
  attr_reader :link, :url

  def self.import(link)
    new(link).import
  end

  def self.convert(link)
    new(link).convert
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
      phone: "",
      subs: subs,
      address: address,
      pictures: pictures
    })
  end

  def convert
    return if Listing.exists?(title: l.title)
    l = Listing.create(
      user_id: 1,
      state_id: 3, #arizona
      city_id: 1441, # chandler
      active: false,
      source: "https://svoi.us#{link.source}",
      kind: "услуги",
      category: link.category,
      subcategory: link.subcategory,
      title: link.title,
      text: link.description,
      site: link.site&.gsub("/links?ref=http%3A//", "")&.gsub("/links?ref=", ""),
      phone: link.phone&.gsub("tel:", ""),
      email: link.email&.gsub("mailto:", ""),
      lat: link.address&.match(/lat:.*?,/)&.to_s&.gsub(/lat: |,/, ""),
      lng: link.address&.match(/lon:.*?,/)&.to_s&.gsub(/lon: |,/, "")
    )
    link.pictures.split(",").each_with_index do |img_url, i|
      pic = Picture.new(
        user_id: 1,
        logo: i == 1,
        imageable: l
      )
      pic.image_remote_url = "https://svoi.us#{img_url}"
      pic.save
    end
  end
end
