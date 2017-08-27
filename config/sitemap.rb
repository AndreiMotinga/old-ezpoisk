# frozen_string_literal: true

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

  # add index listings pages
  %w(работа продажи недвижимость услуги).each do |kind|
    add URI.unescape(search_listings_path(kind: kind)),
        priority: 0.9,
        changefreq: "hourly"
  end

  # categories
  %w(работа продажи недвижимость).each do |kind|
    RU_KINDS[kind]["categories"].each do |cat|
      next unless Listing.where(kind: kind, category: cat).any?
      url = search_listings_path(kind: kind, category: cat)
      add URI.unescape(url), priority: 0.8, changefreq: "daily"
    end
  end

  # subcategories
  %w(работа продажи недвижимость).each do |kind|
    RU_KINDS[kind]["categories"].each do |cat|
      RU_KINDS[kind]["subcategories"].each do |sub|
        next unless Listing.where(kind: kind, category: cat, subcategory: sub).any?
        url = search_listings_path(kind: kind, category: cat, subcategory: sub)
        add URI.unescape(url), priority: 0.8, changefreq: "daily"
      end
    end
  end

  # service categories
  RU_KINDS["услуги"]["categories"].each do |cat|
    next unless Listing.where(kind: "услуги", category: cat).any?
    url = search_listings_path(kind: "услуги", category: cat)
    add URI.unescape(url), priority: 0.8, changefreq: "weekly"
  end

  # service subcategories
  RU_KINDS["услуги"]["categories"].each do |cat|
    RU_KINDS["услуги"]["subcategories"][cat].each do |sub|
      if Listing.where(kind: "услуги", category: cat, subcategory: sub).any?
        url = search_listings_path(kind: "услуги", category: cat, subcategory: sub)
        add URI.unescape(url), priority: 0.8, changefreq: "weekly"
      end
    end
  end

  add answers_path, priority: 0.8, changefreq: "daily"
  Answer.find_each do |answer|
    add answer_path(answer),
        priority: 0.6,
        lastmod: answer.updated_at,
        changefreq: "monthly"
  end

  add questions_path, priority: 0.8, changefreq: "daily"
  Question.find_each do |answer|
    add question_path(answer),
        priority: 0.6,
        lastmod: answer.updated_at,
        changefreq: "weekly"
  end

  add posts_path, priority: 0.8, changefreq: "hourly"
  Post.find_each do |post|
    add post_path(post),
        priority: 0.6,
        lastmod: post.created_at,
        changefreq: "never"
  end

  Listing.active.find_each do |listing|
    add URI.unescape(listing_path(listing)),
        priority: 0.4,
        lastmod: listing.updated_at,
        changefreq: "never"
  end

  User.find_each do |user|
    add user_path(user),
        priority: 0.7,
        lastmod: user.updated_at,
        changefreq: "weekly"
  end

  add about_path, priority: 0.3, changefreq: "never"
end
