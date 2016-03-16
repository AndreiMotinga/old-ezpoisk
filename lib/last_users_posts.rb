class LastUsersPosts
  def last_posts(num)
    posts = RePrivate.active.last(100)
    [ReAgency, ReCommercial, ReFinance, Service, JobAgency, Job, Sale].each do |model|
      posts += model.active.last(100)
    end
    posts.sort_by(&:created_at).last(num).reverse
  end
end
