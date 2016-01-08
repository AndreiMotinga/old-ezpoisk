class Feedback < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :email, presence: true
end
