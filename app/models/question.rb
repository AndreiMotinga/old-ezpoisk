class Question < ActiveRecord::Base
  acts_as_taggable
  include MyFriendlyId
  belongs_to :user, optional: true
  has_many :answers
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates_presence_of :tag_list

  scope :by_views, -> { order("impressions_count desc") }
  scope :older, -> (id) { where("id > ?", id) }

  has_one :entry, as: :enterable, dependent: :destroy

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.term_for(term)
    qs = where("LOWER(title) LIKE ?", "%#{term.mb_chars.downcase}%")
         .limit(10).pluck(:title, :slug)
    qs.map!{ |q| { value: "/questions/#{q[1]}", label: q[0]}}
    qs << { value: "/questions?keyword=#{term}", label: "Искать:  \"#{term}\"" }
    qs << { value: "/questions/new?question=#{term}",
            label: "Спросить:  \"#{term}\"" }
  end

  def self.unanswered
    where("questions.id NOT IN (SELECT DISTINCT(question_id) FROM answers)")
  end

  def self.convert_keyword(keyword)
    keyword.gsub(/[^0-9a-zа-я ]/i, "")
           .split(" ")
           .map { |key| "%#{key.mb_chars.downcase}%" }
  end

  def side_questions
    qs = Question.tagged_with(tag_list, any: true)
    older_qs = qs.older(id).by_views.limit(20) - [self]
    return older_qs unless older_qs.size < 5
    qs.by_views.limit(20) - [self]
  end

  def image
    return image_url if image_url.present?
    "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  def subscribers_emails
    subscriptions.map(&:user).pluck(:email)
  end

  def has_answers?
    !!answers.first
  end

  def show_url
    Rails.application.routes.url_helpers.question_url(self)
  end

  def active
    true
  end
end
