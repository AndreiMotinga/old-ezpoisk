# frozen_string_literal: true

module Mappable
  extend ActiveSupport::Concern

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
end
