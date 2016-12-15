require "rails_helper"

describe "Home page" do
  describe "GET #index" do
    it "renders the new temlpate" do
      get "/"

      expect(response).to render_template(:index)
      expect(response.body).to include("ezpoisk.com")
    end
  end
end
