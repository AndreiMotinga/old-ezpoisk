class Entry < ActiveRecord::Base
  belongs_to :enterable, polymorphic: true
  belongs_to :user

  scope :desc, -> { order("#{table_name}.created_at desc") }
  scope :today, -> { where("#{table_name}.created_at > ?", Date.today) }
  scope :week, -> { where("#{table_name}.created_at > ?",
                          Date.today.at_beginning_of_week) }

  scope :articles, -> { where(enterable_type: %w(Answer Post)) }
  scope :news, -> { where(enterable_type: %w(Answer Post Review Question)) }
  scope :listings, -> { where(enterable_type: %w(RePrivate Sale Service Job)) }
end
