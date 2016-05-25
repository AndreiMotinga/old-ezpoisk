require "rails_helper"

describe Dashboard::PartnersController do
  describe "GET #index" do
    render_views

    it "returns user's ad blocks" do
      user = create(:user)
      sign_in(user)
      2.times { create :partner, user: user }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:partners).size).to eq 2
    end
  end
end
