# frozen_string_literal: true

class Question < ActiveRecord::Base
  acts_as_taggable
  acts_as_votable

  include Filterable
  include Commentable
  include MyFriendlyId
  include Searchable
  include Impressionable
  include Karmable
  include ArticleExportable

  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :answers, dependent: :destroy
  has_one :action, as: :actionable, dependent: :destroy

  validates :user, presence: true
  validates :title, presence: true, uniqueness: true, length: { minimum: 10, maximum: 260 }
  validates_presence_of :tag_list

  after_create :create_action
  # move it to module
  after_create :export
  before_save :verify_title
  after_save :update_cached_tags

  # todo duplicated with answer - do it nicer
  def score
    get_upvotes.count - get_downvotes.count
  end

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
    # return image_url if image_url.present?
    "https://s3.amazonaws.com/ezpoisk/missing.png"
  end

  def show_url
    Rails.application.routes.url_helpers.question_url(self)
  end

  def logo_url
    answers.where.not(logo_url: nil).pluck(:logo_url).sample
  end

  def related(n)
    Question.older(created_at)
            .tagged_with(tag_list, any: true)
            .order(created_at: :desc)
            .take(n)
  end

  private

  def update_cached_tags
    update_column(:cached_tags, tags.pluck(:name).join(","))
    answers.find_each do |a|
      a.cached_tags = cached_tags
      a.tag_list = tag_list
      a.save
    end
  end

  def verify_title
    self.title = title.strip
    self.title += "?" unless title.match(/\?$/)
    self.title = title.capitalize
  end

  def export
    ArticleExporterJob.perform_async("Question", id)
  end
end
