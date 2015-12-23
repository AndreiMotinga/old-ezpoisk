require 'rails_helper'

describe User do
  it { should have_many(:re_agencies) }
  it { should have_many(:re_privates) }
  it { should have_many(:re_commercials) }
end
