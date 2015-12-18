require "rails_helper"

describe State do
  it { should have_many(:cities) }
end
