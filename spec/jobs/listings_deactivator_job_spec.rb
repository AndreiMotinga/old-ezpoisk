require "rails_helper"

xdescribe ListingsDeactivatorJob do
  it "deactivates listings that weren't edited for more than 30 days" do
    listing = create :listing
    create_list :listing, 10, updated_at: 32.days.ago

    ListingsDeactivatorJob.perform_async
    ListingsDeactivatorJob.drain

    expect(Listing.active.count).to eq 1
  end

  it "destroys ez's listings" do
    ez = create :user
    user = create :user
    create :listing
    create :listing, updated_at: 32.days.ago, user_id: user.id
    create_list :listing, 10, updated_at: 32.days.ago, user_id: ez.id

    ListingsDeactivatorJob.perform_async
    ListingsDeactivatorJob.drain

    expect(Listing.count).to eq 2
    expect(Listing.active.count).to eq 1
  end
end
