# frozen_string_literal: true

module UtilRoutes
  def self.extended(router)
    router.instance_exec do

      # Utils
      get "sitemaps/sitemap.:format.:compression", to: "sitemap#show"
      get "sitemaps/sitemap:id.:format.:compression", to: "sitemap#show_id"

    end
  end
end
