require "rails_helper"

describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should validate_presence_of :category }
end
