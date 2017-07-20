class Post < ApplicationRecord
  include Filterable
  belongs_to :user
end
