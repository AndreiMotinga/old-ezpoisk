require "rails_helper"

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }

  # PRIVATE

  it "private updates logo before save" do
    post = build :post, text: "Foo <img src='some_url'/>Bar"

    post.save
    post.reload

    expect(post.logo_url).to eq "some_url"
  end
end
