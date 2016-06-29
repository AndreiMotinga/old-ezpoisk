require "rails_helper"

describe HomeController do
  describe "GET index" do
    it "renders home page and assigns @homepage" do
      q = create(:question, updated_at: 2.days.ago)
      s = create(:service, updated_at: 1.day.ago)
      # todo remove trait active
      rp = create(:re_private, :active)

      get :index
      listings = assigns(:listings).map(&:title)
      expected = [rp, s, q].map(&:title)

      expect(response).to render_template(:index)
      expect(listings).to eq expected
    end
  end
end
