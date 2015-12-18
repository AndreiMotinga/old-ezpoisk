class ReAgency < ActiveRecord::Base
  # include Filterable

  # after_save :create_agent

  validates :street, presence: true
  validates :user, uniqueness: true
  validates :title, presence: true, length: {maximum: 90, minimum: 5}
  validates :state_id, presence: true
  validates :city_id, presence: true
  validates :phone, presence: true

  belongs_to :user
  belongs_to :picture # logo

  has_many :pictures, as: :imageable
  has_many :re_privates
  # has_many :re_agents, dependent: :destroy
  has_many :re_privates, through: :re_agents
  has_many :re_commercials, through: :re_agents
  has_many :openhouses, through: :re_agents

  scope :active, -> { where(active: true) }
  scope :state_id, ->(id) { where(state_id: id) }
  scope :city_ids, -> (ids) { where(city_id: ids.split(',')) }

  private
    # def create_agent
    #   ReAgent.create(user_id: self.user_id, re_agency_id: self.id)
    # end
end
