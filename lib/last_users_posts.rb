class LastUsersPosts
  def last_posts(num)
    posts = RePrivate.active.last(num)
    [ReCommercial, Service, Job, Sale].each do |model|
      posts += model.active.last(num)
    end
    posts.sort_by(&:created_at).last(num).reverse
  end
end
