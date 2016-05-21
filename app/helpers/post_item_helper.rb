module PostItemHelper
  def link_to_show_page(record)
    case record.class.to_s
    when "Job"
      job_path(record)
    when "RePrivate"
      re_private_path(record)
    when "ReCommercial"
      re_commercial_path(record)
    when "Sale"
      sale_path(record)
    when "Service"
      service_path(record)
    when "Post"
      post_path(record)
    end
  end

  def path_from_site(site)
    site.match(/http/).present? ? site : "http://#{site}"
  end
end
