require "rails_helper"

describe City do
  it { should belong_to(:state) }
end
