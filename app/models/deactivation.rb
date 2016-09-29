class Deactivation < ApplicationRecord
  belongs_to :deactivatable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: [:deactivatable_type, :deactivatable_id]
  }
end
