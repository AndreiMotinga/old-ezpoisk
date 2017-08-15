require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:state) }
end
