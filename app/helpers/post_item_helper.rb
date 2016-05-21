module PostItemHelper
  # todo refactor security
  def path_from_site(site)
    site.match(/http/).present? ? site : "http://#{site}"
  end
end
