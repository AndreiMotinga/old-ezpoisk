require "rails_helper"

describe Service do
  it { should validate_presence_of :title }
  it { should validate_presence_of :street }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :category }
  it { should validate_presence_of :subcategory }

  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :user_id }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }

  it { should have_many(:favorites).dependent(:destroy) }
end
