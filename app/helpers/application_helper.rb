module ApplicationHelper
  def site_link(site)
    site.match(/http/).present? ? site : "http://#{site}"
  end
end
