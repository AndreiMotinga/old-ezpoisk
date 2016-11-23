# todo create request / view spec
require "rails_helper"

describe HomeController do
  describe "GET index" do
    it "renders home page" do
      p = create(:post, visible: true)

      get :index

      expect(response).to render_template(:index)
    end
  end
end
