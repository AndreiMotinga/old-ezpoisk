class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :body, presence: true

  def self.new_one(user)
    new(name: user.try(:name),
        email: user.try(:email))
  end
end
