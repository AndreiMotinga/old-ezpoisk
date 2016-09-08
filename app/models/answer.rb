class Answer < ActiveRecord::Base
  acts_as_taggable
  include Filterable
  include MyFriendlyId
  acts_as_votable
  acts_as_commentable
  belongs_to :user
  belongs_to :question

  has_one :entry, as: :enterable, dependent: :destroy

  delegate :name_to_show, to: :user

  scope :by_score, -> { all.sort_by(&:score).reverse }

  has_attached_file :image, styles: { medium: "810", thumb: "x160#" }
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  attr_reader :image_remote_url
  def image_remote_url=(url_value)
    if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end

  def score
    get_upvotes.count - get_downvotes.count
  end

  def show_url
    Rails.application.routes.url_helpers.answer_url(self)
  end

  def avatar
    user.avatar(:thumb)
  end

  def side_posts
    @posts = Post.visible.last(9)
  end
end
