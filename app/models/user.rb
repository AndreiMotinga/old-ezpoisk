class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async
  after_create :notify_admin

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

  has_attached_file :avatar,
                    styles: { medium: "300x150" },
                    default_url: "missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # forem helpers
  def forem_name
    name
  end

  private

  def notify_admin
    AdminMailerJob.perform_async(id, "User")
  end
end
