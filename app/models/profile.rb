class Profile < ActiveRecord::Base
  include ViewHelpers
  # todo test the shit out of it
  belongs_to :user
  belongs_to :state
  belongs_to :city
  has_many :posts, through: :user
  has_many :answers, through: :user

  has_attached_file(:avatar,
                    styles: { thumb: "50x50#", medium: "160x160#" },
                    default_url: "default-avatar.png")
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_attached_file(:cover,
                    styles: { large: "1140x325#" },
                    default_url: "https://s3.amazonaws.com/ezpoisk/default_cover.jpg")
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def email
    user.email
  end

  def address
    "#{city.name} #{state.name}"
  end

  def name_to_show
    user.name_to_show
  end
end
