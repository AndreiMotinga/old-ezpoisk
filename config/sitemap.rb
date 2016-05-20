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

  add re_privates_path, priority: 0.6, changefreq: "weekly"
  RePrivate.find_each do |post|
    add re_private_path(post), priority: 0.6, lastmod: post.updated_at
  end

  add re_commercials_path, priority: 0.6, changefreq: "weekly"
  ReCommercial.find_each do |post|
    add re_commercial_path(post), priority: 0.6, lastmod: post.updated_at
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

  add posts_path, priority: 0.6, changefreq: "daily"

  Post.find_each do |post|
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
  Sale.find_each do |post|
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

  add services_path, priority: 0.6, changefreq: "weekly"
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

  add jobs_path, priority: 0.6, changefreq: "weekly"
  Job.find_each do |post|
    add jobs_path(post),
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

  add questions_path, priority: 0.8, changefreq: "daily"
  Question.find_each do |question|
    add question_path(question),
        priority: 0.7,
        lastmod: question.updated_at
  end

  ##############################################################
  #
  #     // EZANSWER
  #
  ##############################################################
  #
end
