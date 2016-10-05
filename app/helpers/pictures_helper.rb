module PicturesHelper
  def alt_text(rec)
    case rec.class.name
    when "RePrivate" then re_private_alt_text(rec)
    when "Sale" then sale_alt_text(rec)
    when "Service" then service_alt_text(rec)
    end
  end

  def re_private_alt_text(rec)
    "#{rec.street} #{t rec.post_type} #{t rec.rooms} #{rec.cached_city.name}
     #{rec.cached_state.name} #{rec.zip}"
  end

  def sale_alt_text(rec)
    "Продается #{t rec.category} #{rec.title} #{rec.cached_city.name}
    #{rec.cached_state.name}"
  end
end
