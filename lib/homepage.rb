class Homepage
  def questions
    Question.answered.last(15)
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
