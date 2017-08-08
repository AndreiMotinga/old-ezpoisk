
doc = Nokogiri::HTML(p)
if img = doc.xpath('//img').first
    p img.attr('src')
end

# verify remember me
#
#

User.find_each do |u|
  attrs = {
    phone: u.phone,
    site: u.site,
    skype: u.skype,
    vk: u.vk,
    fb: u.facebook,
    google: u.google,
    street: u.street,
    city_id: u.city_id && City.exists?(u.city_id) ? u.city_id : 18031,
    state_id: u.state_id && State.exists?(u.state_id) ? u.state_id : 32
  }

  u.create_contact(attrs)
end
