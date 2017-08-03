class Experience < ApplicationRecord
  belongs_to :user

  validates_presence_of :kind
  validates_presence_of :name
  validates_presence_of :title
  validates_presence_of :country
  validates_presence_of :city
  validates_presence_of :start_year

  scope :job, -> { where(kind: "job") }
  scope :education, -> { where(kind: "education") }
end
