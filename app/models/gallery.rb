class Gallery < ApplicationRecord
  belongs_to :user
  has_many :pictures, as: "imageable"
end
