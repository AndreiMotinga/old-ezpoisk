class LastUsersPosts
  def last_posts(num)
    posts = RePrivate.last(100)
    [Service, Job, Sale].each do |model|
      posts += model.last(100)
    end
    posts.sort_by(&:created_at).last(num).reverse
  end
end
