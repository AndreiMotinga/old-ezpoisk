class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :user
  belongs_to :post
  default_scope { order("created_at desc") }
end
