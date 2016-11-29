require "rails_helper"

describe Review do
  it { should belong_to(:user) }

  it { should validate_presence_of :rating }
  it { should validate_presence_of :text }
  it { should validate_presence_of :listing }
  it { should validate_presence_of :user }
end
