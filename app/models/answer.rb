class Answer < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :question

  scope :by_score, -> { all.sort_by(&:score).reverse }

  def score
    get_upvotes.size - get_downvotes.size
  end

  def link
    "ezanswer/#{question_id}"
  end
end
