class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :async

  validates :phone, presence: true
  validates :name, presence: true

  has_many :re_agencies
  has_many :re_privates
  has_many :re_commercials

  # add test
  has_many :job_agencies
  has_many :jobs
end
