class Post < ApplicationRecord
  acts_as_taggable
  include Filterable
  include Commentable
  belongs_to :user


  delegate :avatar, :name_to_show, to: :user

  has_one :action, as: :actionable, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 70 }
  validates_presence_of :text
  validates_presence_of :tag_list

  after_create :create_action

  def show_url
    Rails.application.routes.url_helpers.post_url(self)
  end
end
