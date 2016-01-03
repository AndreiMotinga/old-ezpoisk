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
    Gmaps4rails.build_markers(self) do |re_private, marker|
      marker.lat re_private.latitude
      marker.lng re_private.longitude
      marker.infowindow re_private.infowindow
    end
  end

  def infowindow
    "<a href='http://maps.google.com/?q=#{address}' target='blank'>#{address}</a>"
  end
end
