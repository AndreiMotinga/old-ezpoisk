require "rails_helper"

describe Comment do
  it { should belong_to(:commentable) }
  it { should validate_presence_of :text }
  it { should validate_presence_of :user_id }
end
