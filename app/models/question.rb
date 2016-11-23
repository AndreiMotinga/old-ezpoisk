class Question < ActiveRecord::Base
  acts_as_taggable
  include MyFriendlyId
  include Searchable
  include Commentable

  belongs_to :user, optional: true
  belongs_to :state
  belongs_to :city
  has_many :answers
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates_presence_of :tag_list

  def self.term_for(term)
    qs = where("title ILIKE ?", "%#{term}%").limit(10).pluck(:title, :slug)
    qs.map!{ |q| { value: "/questions/#{q[1]}", label: q[0]}}
    qs << { value: "/answers?term=#{term.gsub(" ", "+")}", label: "Искать:  \"#{term}\"" }
    qs << { value: "/questions/new?question=#{term}",
            label: "Создать вопрос:  \"#{term}\"" }
  end

  def self.unanswered
    where("questions.id NOT IN (SELECT DISTINCT(question_id) FROM answers)")
  end

  def image
    return image_url if image_url.present?
    "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  def subscribers_emails
    subscriptions.map(&:user).pluck(:email)
  end

  def show_url
    Rails.application.routes.url_helpers.question_url(self)
  end

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(", "))
  end

  def active
    true
  end
end
