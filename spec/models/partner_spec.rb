require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:budget) }
  it { should validate_presence_of(:email) }
  it { should belong_to(:user) }
end
