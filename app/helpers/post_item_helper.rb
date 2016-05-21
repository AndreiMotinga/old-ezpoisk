module PostItemHelper
  def path_from_site(site)
    site.match(/http/).present? ? site : "http://#{site}"
  end
end
