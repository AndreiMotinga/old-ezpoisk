class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :timeoutable, :validatable, :lockable, :async
  after_create :notify_admin
  before_save :format_phone

  acts_as_voter

  validates :phone, presence: true
  validates :name, presence: true
  validates :state_id, presence: true
  validates :city_id, presence: true

  belongs_to :state
  belongs_to :city

  has_many :re_agencies, dependent: :destroy
  has_many :re_privates, dependent: :destroy
  has_many :re_commercials, dependent: :destroy
  has_many :job_agencies, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :posts
  has_many :feedbacks
  has_many :pictures
  has_many :questions
  has_many :answers, through: :questions

  has_attached_file :avatar,
    styles: { medium: "200x200#" },
    :s3_protocol => :https,
    default_url: "default-avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def role?(val)
    role.to_sym == val
  end

  def timeout_in
    self.admin? ? 2.hours : 7.days
  end

  private

  def notify_admin
    AdminMailerJob.perform_async(id, "User")
    SlackNotifierJob.perform_async(id, "User")
  end

  def format_phone
    phone.gsub!(/\D/, "")
  end
end
