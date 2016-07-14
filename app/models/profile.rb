class Profile < ActiveRecord::Base
  acts_as_mappable
  include ViewHelpers
  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :posts, through: :user
  has_many :answers, through: :user
  has_many :points

  delegate :email, to: :user, prefix: true
  delegate :name_to_show, to: :user, prefix: true
  delegate :name, to: :user

  has_attached_file(
    :cover,
    styles: { large: "800x400#" },
    default_url: "https://s3.amazonaws.com/ezpoisk/default_cover.jpg")
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}
end
