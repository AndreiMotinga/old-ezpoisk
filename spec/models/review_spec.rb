require "rails_helper"

describe Review do
  it { should validate_presence_of :rating }
  it { should validate_presence_of :text }
  it { should validate_presence_of :service_id }
  it { should validate_presence_of :user_id }

  it { should belong_to(:user) }
  it { should belong_to(:service) }
end
