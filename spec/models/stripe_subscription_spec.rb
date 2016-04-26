require 'rails_helper'

describe StripeSubscription do
  it { should belong_to(:payable) }
end
