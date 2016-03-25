class Homepage
  def questions(num)
    Question.by_views.limit(num)
  end

  def news_posts(num)
    Post.for_homepage.desc.limit(num)
  end

  def main_posts(num)
    Post.main_posts.limit(num)
  end

  def users_posts(num)
    LastUsersPosts.new.last_posts(num)
  end
end
