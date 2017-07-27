require "rails_helper"

describe "Listings" do
  describe "GET #index" do
    it "renders index temlpate" do
      get listings_path

      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders show template with listing" do
      listing = create :listing

      get listing_path listing

      expect(response).to render_template(:show)
      expect(response.body).to include(listing.title)
    end
  end
end
