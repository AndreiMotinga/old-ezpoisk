require 'rails_helper'

describe User do
  it { should belong_to(:state) }
  it { should belong_to(:city) }

  it { should have_many(:re_agencies).dependent(:destroy) }
  it { should have_many(:re_privates).dependent(:destroy) }
  it { should have_many(:re_commercials).dependent(:destroy) }
  it { should have_many(:job_agencies).dependent(:destroy) }
  it { should have_many(:jobs).dependent(:destroy) }
  it { should have_many(:services).dependent(:destroy) }
  it { should have_many(:sales).dependent(:destroy) }
  it { should have_many(:posts) }
end
