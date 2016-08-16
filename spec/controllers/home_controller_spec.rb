require "rails_helper"

describe HomeController do
  describe "GET index" do
    it "renders home page and assigns @entries" do
      p = create(:post, visible: true, home: true)

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:posts)).to match [p]
    end
  end
end
