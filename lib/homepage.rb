class Homepage
  def questions(num)
    Question.order("created_at desc").limit(num)
  end

  def news_posts(num)
    Post.desc.visible.limit(num)
  end

  def users_posts(num)
    MODELS.map { |model| model[1].constantize.active.last(num) }
          .flatten!
          .sort_by(&:created_at).last(num).reverse
  end
end
