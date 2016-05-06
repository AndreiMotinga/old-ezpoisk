class Answer < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :question

  delegate :title, to: :question, prefix: true

  scope :by_score, -> { all.sort_by(&:score).reverse }

  def score
    get_upvotes.size - get_downvotes.size
  end

  def user_avatar
    user.profile.avatar.url(:thumb)
  end
end
