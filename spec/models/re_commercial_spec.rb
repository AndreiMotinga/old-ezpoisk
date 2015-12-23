require "rails_helper"

describe ReCommercial do
  it { should validate_presence_of :price }
  it { should validate_presence_of :post_type }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :street }

  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }
end
