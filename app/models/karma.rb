class Karma < ApplicationRecord
  belongs_to :user
  belongs_to :giver, class_name: "User"
  belongs_to :karmable, polymorphic: true

  validates :user, presence: true
  validates :karmable, presence: true
  validates :kind, presence: true
  validates :amount, presence: true

  before_validation :set_amount

  AMOUNTS = {
    Question: {
      created: 20,
      upvoted: 10
    },
    Answer: {
      created: 50,
      upvoted: 10
    },
    Post: {
      created: 10,
      upvoted: 5,
    },
    User: {
      thanked: 100,
      created: 10
    }
  }

  private

  def set_amount
    self.amount = AMOUNTS[karmable_type.to_sym][kind.to_sym]
  end
end
