require 'rails_helper'

describe User do
  it { should have_many(:re_privates).dependent(:destroy) }
  it { should have_many(:re_commercials).dependent(:destroy) }
  it { should have_many(:jobs).dependent(:destroy) }
  it { should have_many(:services).dependent(:destroy) }
  it { should have_many(:stripe_subscriptions) }
  it { should have_many(:sales).dependent(:destroy) }
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:posts) }

  it { should have_one(:profile) }
end
