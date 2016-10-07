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

  #     REAL ESTATE
  add re_privates_path, priority: 0.8, changefreq: "daily"

  ids = RePrivate.active.uniq.pluck(:city_id)
  ids.each do |id|
    city = City.find(id)
    state_slug = city.state.slug
    city_slug = city.slug
    add search_re_privates_path(state: state_slug, city: city_slug),
        priority: 0.7,
        lastmod: Time.zone.now,
        changefreq: "daily"
  end

  RePrivate.active.find_each do |rec|
    add re_private_path(rec),
        priority: 0.4,
        lastmod: rec.updated_at,
        changefreq: "monthly"
  end

  #     SALES
  add sales_path, priority: 0.8, changefreq: "daily"

  ids = Sale.active.uniq.pluck(:city_id)
  ids.each do |id|
    city = City.find(id)
    state_slug = city.state.slug
    city_slug = city.slug
    add search_sales_path(state: state_slug, city: city_slug),
        priority: 0.7,
        lastmod: Time.zone.now,
        changefreq: "daily"
  end

  Sale.active.find_each do |post|
    add sale_path(post),
        priority: 0.4,
        lastmod: post.updated_at,
        changefreq: "monthly"
  end

  #     SERVICES
  add services_path, priority: 0.8, changefreq: "daily"

  ids = Service.active.uniq.pluck(:city_id)
  ids.each do |id|
    city = City.find(id)
    state_slug = city.state.slug
    city_slug = city.slug
    add search_services_path(state: state_slug, city: city_slug),
        priority: 0.7,
        lastmod: Time.zone.now,
        changefreq: "daily"
  end

  Service.find_each do |post|
    add service_path(post),
        priority: 0.4,
        lastmod: post.updated_at,
        changefreq: "monthly"
  end

  #     JOBS
  add jobs_path, priority: 0.8, changefreq: "daily"

  ids = Job.active.uniq.pluck(:city_id)
  ids.each do |id|
    city = City.find(id)
    state_slug = city.state.slug
    city_slug = city.slug
    add search_jobs_path(state: state_slug, city: city_slug),
        priority: 0.7,
        lastmod: Time.zone.now,
        changefreq: "daily"
  end

  Job.active.find_each do |post|
    add job_path(post),
        priority: 0.4,
        lastmod: post.updated_at,
        changefreq: "monthly"
  end

  add answers_path, priority: 0.8, changefreq: "weekly"
  Answer.find_each do |answer|
    add answer_path(answer),
        priority: 0.6,
        lastmod: answer.updated_at,
        changefreq: "monthly"
  end

  add posts_path, priority: 0.8, changefreq: "daily"
  Post.visible.find_each do |post|
    add post_path(post),
        priority: 0.5,
        lastmod: post.updated_at,
        changefreq: "monthly"
  end

  User.find_each do |user|
    add user_path(user),
        priority: 0.4,
        lastmod: user.updated_at,
        changefreq: "monthly"
  end
end
