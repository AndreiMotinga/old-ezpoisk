require "rails_helper"

describe Feedback do
  it { should belong_to(:user) }
end
