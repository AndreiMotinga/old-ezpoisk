require 'rails_helper'

RSpec.describe Partner, type: :model do
  it { should belong_to(:campaign) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_most(45) }
  it { should validate_presence_of(:final_url) }
  it { should validate_presence_of(:headline) }
  it { should validate_length_of(:headline).is_at_most(45) }
end
