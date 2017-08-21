# frozen_string_literal: true

class Answer < ActiveRecord::Base
  acts_as_taggable
  acts_as_votable
  include MyFriendlyId
  include Commentable
  include Filterable
  include Impressionable

  belongs_to :user
  belongs_to :question, touch: true, counter_cache: true
  belongs_to :state
  belongs_to :city
  has_one :action, as: :actionable, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  delegate :name, to: :user
  delegate :avatar, to: :user

  after_create :create_action
  after_create :update_cached_tags
  before_save :update_logo

  def score
    get_upvotes.count - get_downvotes.count
  end

  def self.for_question(n, q)
    sort = "case when logo_url is null then -1 else 1 end desc, created_at desc"
    Answer.older(q.created_at)
          .tagged_with(q.tag_list, any: true)
          .order(sort)
          .take(n)
  end

  def show_url
    Rails.application.routes.url_helpers.answer_url(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers.edit_answer_url(self)
  end

  def related(n, logo = nil)
    sort = "created_at desc"
    sort = "case when logo_url is null then -1 else 1 end desc, " + sort if logo
    Answer.older(created_at)
          .tagged_with(tag_list, any: true)
          .order(sort)
          .take(n)
  end

  private

  def update_cached_tags
    update_column(:cached_tags, question.tags.pluck(:name).join(","))
  end

  def update_logo
    img = Nokogiri::HTML(text).xpath("//img").first
    self.logo_url = img.attr("src") if img
  end
end
