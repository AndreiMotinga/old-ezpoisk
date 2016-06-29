# aggregates listings, posts, and questions to display on homepage
#
# frozen_string_literal: true
class Homepage
  MODELS = [RePrivate, ReCommercial, Service, Job, Sale].freeze

  def self.users_activity(num)
    records = MODELS.map { |m| m.active.order("updated_at desc").first(num) }
    records += Question.order("updated_at desc").limit(num)
    records += Post.order("updated_at desc").limit(num)
    records.flatten!.sort_by(&:updated_at).last(num).reverse
  end
end
