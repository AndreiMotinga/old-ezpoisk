class Answer < ActiveRecord::Base
  acts_as_taggable
  include Filterable
  include MyFriendlyId
  include ListingHelpers
  include Commentable
  acts_as_votable

  belongs_to :user
  belongs_to :question
  belongs_to :state
  belongs_to :city
  has_one :entry, as: :enterable, dependent: :destroy

  validates :title, presence: true
  validates :text, presence: true
  delegate :name_to_show, to: :user

  has_attached_file :image, styles: { medium: "x330>", thumb: "x160#" }
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

  def edit_url_with_token
    Rails.application.routes.url_helpers.edit_answer_url(self)
  end

  def avatar
    user.avatar(:thumb)
  end

  def similar
    Answer.includes(:user)
          .tagged_with(tag_list, any: true)
          .random
          .limit(10)
  end

  def active
    true
  end
end
