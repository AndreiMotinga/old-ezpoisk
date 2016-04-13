module ViewHelpers
  extend ActiveSupport::Concern

  def logo
    pictures.find_by_logo(true)
  end

  def logo_url(style = :medium)
    logo.present? ? logo.image.url(style) : "https://s3.amazonaws.com/ezpoisk/missing.png"
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
      marker.lat post.try(:lat)
      marker.lng post.try(:lng)
      marker.infowindow post.infowindow
    end
  end

  def infowindow
    "<a href='https://maps.google.com/?q=#{address}' target='blank'>#{address}</a>"
  end

  def favorite?(user)
    return false unless user
    Favorite.exists?(user_id: user.id,
                     post_id: id,
                     post_type: self.class.to_s,
                     favorite: true)
  end

  def user_hidden?(user)
    return false unless user
    Favorite.exists?(user_id: user.id,
                     post_id: id,
                     post_type: self.class.to_s,
                     hidden: true)
  end
end
