# todo remove
class Service < ActiveRecord::Base
  acts_as_mappable
  include Filterable
  include ListingHelpers
  include Tokenable
  include Cachable

  validates :title, presence: true, length: { maximum: 44, minimum: 3 }
  validates :category, presence: true
  validates :subcategory, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :street, presence: true
  validates :phone, presence: true

  belongs_to :state
  belongs_to :city
  belongs_to :user, optional: true
  has_many :favorites, as: :favorable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :reviews

  has_attached_file :logo, styles: { medium: "x120",
                                     avatar: "100x100#", right: "300x250#" }
  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_file_name :logo, matches: [/png\Z/i, /jpe?g\Z/i]
  validates_with(
    AttachmentSizeValidator,
    attributes: :logo,
    less_than: 1.megabytes
  )

  has_attached_file(:cover, styles: { large: "780x390#" },
    default_url: "https://s3.amazonaws.com/ezpoisk/pictures/service-default-cover.jpg")
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\Z}

  def edit_link
    Rails.application.routes.url_helpers.edit_dashboard_service_path(self)
  end

  def edit_url_with_token
    Rails.application.routes.url_helpers
                            .edit_dashboard_service_url(self, token: token)
  end

  def show_url
    Rails.application.routes.url_helpers.service_url(self)
  end

  def rating
    avg = reviews.average(:rating)
    return 0 unless avg
    avg.round
  end

  def side_items
    Service.category(category)
           .subcategory(subcategory)
           .where.not(id: id)
           .order("featured desc, priority desc, created_at desc")
           .limit(3)
  end

  def active?
    true
  end

  CATEGORIES = %w(auto lawers beauty medical real-estate education work repairs
                  construction stores other).freeze
  SUBCATEGORIES = HashWithIndifferentAccess.new(
    "auto": %w(car-rentals autoservices carwash auto-stores driver-schools
               auto-auction moving carservice),
    "lawers": %w(general accidents business paralegal immigration criminal
                 heritage real-estate family),
    "beauty": %w(beauty-salons spa correction epilation tatoo sauna),
    "medical": %w(hospitals farmacies alternative-medicine veterinary-clinics
                  allergist venereologist gynecologis dermotolog nutritionist
                  immunologist cardiologist beautician ent chiropractor
                  neurologist dentist oncologist orthopedist ophthalmologist
                  pediatrician plastic-surgeon psychiatrist psychologist
                  seksopatolog family-doctor therapist urologist surgeon
                  physiotherapist endocrinologist),
    "real-estate": %w(realtors financing),
    "education": %w(schools art-education kinder-gardens english-lessons
                    teachers sport-schools training),
    "work": %w(job-agencies),
    "repairs": %w(cellphone-repair computer-repair appliances-repair
                  clothes-repais musical-instruments-repair-tuning),
    "construction": %w(construction-companies electicians plumbers painters
                       handymen furniture alarm-video-surveillance locks
                       fences-welding garbage interior-design air-conditioning),
    "stores": %w(kid-goods stores-with-delivery pet-stores online-stores
                 stationery book-stores clothes-stores shoe-stores
                 perfumes-cosmetics-stores gift-stores food garden
                 fabric-craft-supplies household-goods flower-stores wathces
                 jewlery car-parts),
    "other": %w(artists-celebrities business detectives exterminators
                computers confectioners nannies tranlations parcels advertisement
                restourants funeral-services sports escort insurance tourism
                dance cleaning finances-taxes photo-video art flowers
                erotics-massage psychic other)
  ).freeze
end
