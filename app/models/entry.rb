class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true
  belongs_to :user

  validates :user_id, presence: true

  scope :today, -> { where("updated_at > ?", Date.today) }
  scope :week, -> { where("created_at > ?", Date.today.at_beginning_of_week) }

  def self.by_type(type)
    return all unless type.present?
    where("enterable_type = ?", type)
  end

  def self.homepage
    where(enterable_type: %w(Post))
  end
end
