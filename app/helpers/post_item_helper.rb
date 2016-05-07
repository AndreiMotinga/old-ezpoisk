module PostItemHelper
  def edit_link(record)
    case record.class.to_s
    when "Job"
      edit_dashboard_job_path(record)
    when "RePrivate"
      edit_dashboard_re_private_path(record)
    when "ReCommercial"
      edit_dashboard_re_commercial_path(record)
    when "Sale"
      edit_dashboard_sale_path(record)
    when "Service"
      edit_dashboard_service_path(record)
    when "Post"
      edit_dashboard_post_path(record)
    end
  end

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
