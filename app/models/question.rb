class Question < ActiveRecord::Base
  is_impressionable :counter_cache => true
  acts_as_taggable
  include MyFriendlyId
  belongs_to :user
  has_many :answers
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, presence: true

  scope :by_views, -> { order("impressions_count desc") }
  scope :older, -> (id) { where("id > ?", id) }

  def self.by_keyword(keyword)
    return all if keyword.blank?
    keys = convert_keyword(keyword)
    query = "LOWER(title) ILIKE ANY (array[?]) OR LOWER(text) ILIKE ANY (array[?])"
    where(query, keys, keys)
  end

  def self.term_for(term)
    qs = where("LOWER(title) LIKE ?", "%#{term.mb_chars.downcase}%")
    qs = qs.limit(10).pluck(:title, :slug)
    qs.map!{ |q| { value: "/ezanswer/#{q[1]}", label: q[0]}}
    qs << { value: "/ezanswer?keyword=#{term}", label: "Искать:  \"#{term}\"" }
  end

  def self.unanswered
    where('id NOT IN (SELECT DISTINCT(question_id) FROM answers)')
  end

  def self.answered
    where('id IN (SELECT DISTINCT(question_id) FROM answers)')
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

  def the_answer
    answers.last
  end

  def text_to_show
    return the_answer.text if the_answer.present?
    text
  end

  def avatar
    return the_answer.user.avatar.url(:thumb) if the_answer.try(:user)
  end

  def username
    return the_answer.user.name if the_answer.try(:user)
  end

  def userslug
    # todo WTF?
    return the_answer.user.slug if the_answer.try(:user)
  end
end
