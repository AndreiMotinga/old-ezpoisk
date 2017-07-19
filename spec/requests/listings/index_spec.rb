require "rails_helper"

describe "Listings" do
  describe "GET #index" do
    it "renders index temlpate" do
      get "/listings"

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders show template with listing" do
      listing = create :listing

      get "/listings/#{listing.id}"

      expect(response).to render_template(:show)
      expect(response.body).to include(listing.title)
    end
  end
end
