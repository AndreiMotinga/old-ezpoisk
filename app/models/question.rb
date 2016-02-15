class Question < ActiveRecord::Base
  is_impressionable
  belongs_to :user
  has_many :answers
end
