require "rails_helper"

describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title  }
  it { should validate_presence_of :category }
  it { should belong_to(:user) }
end
