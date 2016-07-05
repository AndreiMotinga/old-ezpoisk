require "rails_helper"

describe HomeController do
  describe "GET index" do
    it "renders home page and assigns @entries" do
      # q = create(:question, updated_at: 2.days.ago)
      # q.create_entry
      s = create(:service, :active, updated_at: 1.day.ago)
      s.create_entry(updated_at: s.updated_at)
      # todo remove trait active
      rp = create(:re_private, :active)
      rp.create_entry(updated_at: rp.updated_at)

      get :index
      entries = assigns(:entries).map{|e| e.enterable.title }
      expected = [rp, s].map(&:title)

      expect(response).to render_template(:index)
      expect(entries).to eq expected
    end
  end
end
