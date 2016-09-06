require "rails_helper"

describe HomeController do
  describe "GET index" do
    it "renders home page and assigns @entries" do
      p = create(:post, visible: true)
      p.create_entry(user: create(:user))

      get :index

      # todo test for entries
      expect(response).to render_template(:index)
      expect(assigns(:entries).size).to eq 1
    end
  end
end
