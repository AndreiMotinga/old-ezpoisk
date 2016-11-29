##############################################################
#
#     GENERAL SETTINGS
#
##############################################################

SitemapGenerator::Sitemap.default_host = "https://www.ezpoisk.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.search_engines[:yandex] = "https://webmaster.yandex.ru/site/map.xml?url=%s"

##############################################################
#
#     GENERAL SETTINGS ///
#
##############################################################

SitemapGenerator::Sitemap.create do
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: priority: 0.5, changefreq: 'weekly', lastmod: Time.now, host: default_host
  #
  # Examples:
  #
  # Add '/articles'
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add listings_path, priority: 0.8, changefreq: "daily"
  Listing.active.find_each do |listing|
    add listing_path(listing),
        priority: 0.4,
        lastmod: listing.updated_at,
        changefreq: "monthly"
  end

  add answers_path, priority: 0.8, changefreq: "weekly"
  Answer.find_each do |answer|
    add answer_path(answer),
        priority: 0.6,
        lastmod: answer.updated_at,
        changefreq: "monthly"
  end

  User.find_each do |user|
    add user_path(user),
        priority: 0.4,
        lastmod: user.updated_at,
        changefreq: "monthly"
  end
end
