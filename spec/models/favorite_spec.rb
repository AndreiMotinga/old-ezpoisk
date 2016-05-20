require "rails_helper"

describe Favorite do
  it { should belong_to(:user) }
  it { should belong_to(:favorable) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:favorable_id) }
  it { should validate_presence_of(:favorable_type) }
end
