module ApplicationHelper
  def site_link(site)
    return "" unless site.present?
    site.match(/http/).present? ? site : "http://#{site}"
  end
end
