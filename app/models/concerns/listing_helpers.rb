module ListingHelpers
  extend ActiveSupport::Concern

  def og_image_url
    cached_logo.present? ? cached_logo.image.url(:large) : "https://s3.amazonaws.com/ezpoisk/ezpoisk.png"
  end

  def logo_url
    if cached_logo.present?
      cached_logo.image.url(:medium)
    else
      "https://s3.amazonaws.com/ezpoisk/missing-small.png"
    end
  end

  def unset_logo
    return unless cached_logo
    cached_logo.update_attribute(:logo, false)
    Rails.cache.delete([self.class.name, id, :cached_logo])
  end

  def address
    "#{street} #{cached_city.try(:name)} #{cached_state.try(:name)} #{zip}".strip
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

  def vk_message
    html = "#{title}\n"
    html += "#{I18n.t(self.try(:post_type))}\n" if self.try(:post_type).present?
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
