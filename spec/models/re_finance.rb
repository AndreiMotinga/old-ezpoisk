require "rails_helper"

describe ReFinance do
  it { should validate_presence_of :title }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :street }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
end