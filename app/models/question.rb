class Question < ActiveRecord::Base
  acts_as_votable
  is_impressionable
  belongs_to :user
  has_many :answers

  scope :by_score, -> { all.sort_by(&:score).reverse }

  def score
    get_upvotes.size - get_downvotes.size
  end
end
