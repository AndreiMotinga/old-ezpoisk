class Homepage
  def questions(num)
    Question.order("created_at desc").limit(num)
  end

  def news_posts(num)
    Post.desc.limit(num)
  end

  def users_posts(num)
    LastUsersPosts.new.last_posts(num)
  end
end
