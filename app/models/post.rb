class Post < ApplicationRecord
  include Filterable
  belongs_to :user

  delegate :avatar, :name_to_show, to: :user

  after_create :create_action
end
