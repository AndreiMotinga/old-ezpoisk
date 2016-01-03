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

  def show_description
    description.blank? ? I18n.t(:no_description) : description
  end

  def address
    "#{street}, #{city.name} #{state.name}, #{zip}"
  end

  def map_marker
    Gmaps4rails.build_markers(self) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
      marker.infowindow post.infowindow
    end
  end

  def infowindow
    "<a href='http://maps.google.com/?q=#{address}' target='blank'>#{address}</a>"
  end
end
