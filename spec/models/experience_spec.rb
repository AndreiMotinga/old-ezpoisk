require "rails_helper"

RSpec.describe Experience, type: :model do
  it { should validate_presence_of(:kind) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:start_year) }
end
