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

  add ezrealty_re_agencies_path, priority: 0.6, changefreq: "weekly"
  ReAgency.find_each do |post|
    add ezrealty_re_agency_path(post), priority: 0.6, lastmod: post.updated_at
  end

  add ezrealty_re_finances_path, priority: 0.6, changefreq: "weekly"
  ReFinance.find_each do |post|
    add ezrealty_re_finance_path(post), priority: 0.6, lastmod: post.updated_at
  end

  add ezrealty_re_privates_path, priority: 0.6, changefreq: "weekly"
  RePrivate.find_each do |post|
    add ezrealty_re_private_path(post), priority: 0.6, lastmod: post.updated_at
  end

  add ezrealty_re_commercials_path, priority: 0.6, changefreq: "weekly"
  ReCommercial.find_each do |post|
    add ezrealty_re_commercial_path(post), priority: 0.6, lastmod: post.updated_at
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

  add news_index_path, priority: 0.6, changefreq: "daily"

  Post.find_each do |post|
    add news_path(post),
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

  add ezjob_job_agencies_path, priority: 0.6, changefreq: "weekly"
  JobAgency.find_each do |post|
    add ezjob_job_agency_path(post),
        priority: 0.6,
        lastmod: post.updated_at
  end

  add ezjob_jobs_path, priority: 0.6, changefreq: "weekly"
  Job.find_each do |post|
    add ezjob_jobs_path(post),
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
  #     HOROSCOPE
  #
  ##############################################################

  HOROSCOPE_CATEGORIES.each do |category|
    add horoscopes_path(title: category),
        priority: 0.1,
        lastmod: Time.now,
        changefreq: "daily"
  end

  ##############################################################
  #
  #     HOROSCOPE ///
  #
  ##############################################################
  #
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
