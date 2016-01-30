module ViewHelpers
  extend ActiveSupport::Concern

  def logo
    pictures.find_by_logo(true)
  end

  def logo_url(style)
    if logo
      logo.image.url(style)
    else
      "missing.png"
    end
  end

  def address
    "#{street} #{city.name} #{state.name}, #{zip}"
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
end
