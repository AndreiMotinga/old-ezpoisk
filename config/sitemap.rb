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
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  ##############################################################
  #
  #     REAL ESTATE
  #
  ##############################################################

  add re_privates_path, priority: 0.8, changefreq: "daily"
  RePrivate.active.find_each do |post|
    add re_private_path(post), priority: 0.6, lastmod: post.updated_at
  end

  ##############################################################
  #
  #     REAL ESTATE ///
  #
  ##############################################################

  ##############################################################
  #
  #     NEWS
  #
  ##############################################################

  add posts_path, priority: 0.8, changefreq: "daily"

  Post.visible.find_each do |post|
    add post_path(post),
        priority: 0.6,
        lastmod: post.updated_at
  end

  ##############################################################
  #
  #     NEWS ///
  #
  ##############################################################

  ##############################################################
  #
  #     SALES
  #
  ##############################################################

  add sales_path, priority: 0.6, changefreq: "daily"
  Sale.active.find_each do |post|
    add sale_path(post),
        priority: 0.6,
        lastmod: post.updated_at
  end

  ##############################################################
  #
  #     SALES ///
  #
  ##############################################################

  ##############################################################
  #
  #     SERVICES
  #
  ##############################################################

  add services_path, priority: 0.6, changefreq: "daily"
  Service.find_each do |post|
    add service_path(post),
        priority: 0.6,
        lastmod: post.updated_at
  end

  ##############################################################
  #
  #     SERVICES ///
  #
  ##############################################################

  ##############################################################
  #
  #     JOBS
  #
  ##############################################################

  add jobs_path, priority: 0.8, changefreq: "daily"
  Job.active.find_each do |post|
    add job_path(post),
        priority: 0.6,
        lastmod: post.updated_at
  end

  ##############################################################
  #
  #     JOBS ///
  #
  ##############################################################

  ##############################################################
  #
  #     / EZANSWER
  #
  ##############################################################

  add answers_path, priority: 0.8, changefreq: "weekly"
  Answer.find_each do |answer|
    add answer_path(answer),
        priority: 0.7,
        lastmod: answer.updated_at
  end

  ##############################################################
  #
  #     // EZANSWER
  #
  ##############################################################
  #
end
