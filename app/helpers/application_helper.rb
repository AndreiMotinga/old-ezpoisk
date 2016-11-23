module ApplicationHelper
  def site_link(site)
    return "" unless site.present?
    site.match(/http/).present? ? site : "http://#{site}"
  end

  def dashboard_controller?
    controller.class.name.split("::").first == "Dashboard"
  end
end
