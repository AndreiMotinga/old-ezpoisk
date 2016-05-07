require "rails_helper"

describe ListingsAggregator do
  it "returns user's listings" do
    user = create :user
    re_p = create :re_private, :active, user: user
    re_c = create :re_commercial, :active, user: user
    job = create :job, :active, user: user
    sale = create :sale, :active, user: user
    service = create :service, user: user

    listings = ListingsAggregator.new(user).listings

    expect(listings).to match_array [re_p, re_c, service, job, sale]
  end

  it "filters listings by model" do
    user = create :user
    re_p = create :re_private, :active, user: user
    create :re_commercial, :active, user: user
    create :service, user: user
    create :job, :active, user: user
    create :sale, :active, user: user

    listings = ListingsAggregator.new(user, nil, "RePrivate").listings

    expect(listings).to match_array [re_p]
  end

  it "filters listings by keyword" do
    user = create :user
    re_p = create :re_private, :active, user: user, street: "keyword"
    service = create :service, user: user, title: "keyword"
    create :re_commercial, :active, user: user
    create :job, :active, user: user

    listings = ListingsAggregator.new(user, "keyword").listings

    expect(listings).to match_array [re_p, service]
  end

  it "filters listings by keyword and model" do
    user = create :user
    re_p = create :re_private, :active, user: user, street: "keyword foo"
    create :service, user: user, title: "keyword"

    listings = ListingsAggregator.new(user, "keyword", "RePrivate").listings

    expect(listings).to match_array [re_p]
  end
end
