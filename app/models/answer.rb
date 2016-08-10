class Answer < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :question

  delegate :title, to: :question, prefix: true
  delegate :name_to_show, to: :user

  scope :by_score, -> { all.sort_by(&:score).reverse }

  def self.this_week
    where("created_at > ?", Date.current.at_beginning_of_week).count
  end

  def score
    get_upvotes.count - get_downvotes.count
  end

  def show_url
    Rails.application.routes.url_helpers.question_url(question)
  end

  def avatar
    user.avatar(:thumb)
  end
end
