module ListingHelpers
  extend ActiveSupport::Concern

  def logo_url
    return logo.image.url(:medium) if logo.present?
    "https://s3.amazonaws.com/ezpoisk/missing-small.png"
  end

  def logo
    pictures.where(logo: true).first
  end

  def unset_logo
    return unless logo
    logo.update_attribute(:logo, false)
  end

  def address
    "#{street} #{city.try(:name)} #{state.try(:name)} #{zip}".strip
  end

  def map_marker
    Gmaps4rails.build_markers(self) do |post, marker|
      marker.lat post.lat
      marker.lng post.lng
      marker.infowindow post.infowindow
    end
  end

  def infowindow
    "<a href='https://maps.google.com/?q=#{address}'  rel='nofollow' target='blank'>#{address}</a>"
  end

  def notification_email
    return email if email.present?
    user.email
  end

  # todo do I use it?
  def vk_message
    html = "#{title}\n"
    html += "#{I18n.t(self.try(:kind))}\n" if self.try(:kind).present?
    html += "#{I18n.t(self.try(:category))}\n" if self.try(:category).present?
    if self.try(:subcategory).present?
      html += "#{I18n.t(self.try(:subcategory))}\n"
    end
    html += "#{city.name} #{state.name} #{zip}\n"
    html += "#{text}\n"
    html += "Подробнее #{show_url}"
  end

  def contact_email
    return user.email if user.present?
    return email if email.present?
  end

  def clear_phone!
    return unless self.phone.present?
    cleared = self.phone.split(",").map { |num| num.gsub(/\D/, "") }.join(",")
    self.update_attribute(:phone, cleared)
  end
end
