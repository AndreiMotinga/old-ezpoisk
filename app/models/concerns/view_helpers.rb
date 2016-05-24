module ViewHelpers
  extend ActiveSupport::Concern

  def logo
    pictures.find_by_logo(true)
  end

  def logo_url(style = :medium)
    logo.present? ? logo.image.url(style) : "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  def unset_logo
    return unless logo
    logo.update_attribute(:logo, false)
  end

  def address
    if street.present?
      "#{street} #{city.name} #{state.name}, #{zip}"
    elsif zip && zip != 0
      "#{city.name} #{state.name}, #{zip}"
    else
      "#{city.name} #{state.name}"
    end
  end

  def map_marker
    Gmaps4rails.build_markers(self) do |post, marker|
      marker.lat post.lat
      marker.lng post.lng
      marker.infowindow post.infowindow
    end
  end

  def infowindow
    "<a href='https://maps.google.com/?q=#{address}' target='blank'>#{address}</a>"
  end

  def favorite?(user)
    return false unless user
    favorites.where(user_id: user.id, saved: true).exists?
  end

  def user_hidden?(user)
    return false unless user
    favorites.where(user_id: user.id, hidden: true).exists?
  end

  def url_helpers
    Rails.application.routes.url_helpers
  end
end
