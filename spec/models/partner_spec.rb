require "rails_helper"

describe Partner do
  it { should validate_presence_of :title }
  it { should validate_presence_of :image }
  it { should belong_to(:user) }
end
