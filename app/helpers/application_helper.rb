module ApplicationHelper
  def site_link(site)
    return "" unless site.present?
    site.match(/http/).present? ? site : "http://#{site}"
  end

  def destroy_link(record)
    case record.class.to_s
    when "Job"
      dashboard_job_path(record)
    when "RePrivate"
      dashboard_re_private_path(record)
    when "Sale"
      dashboard_sale_path(record)
    when "Service"
      dashboard_service_path(record)
    end
  end

  def dashboard_controller?
    controller.class.name.split("::").first == "Dashboard"
  end
end
