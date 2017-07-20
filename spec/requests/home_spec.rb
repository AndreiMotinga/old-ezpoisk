require "rails_helper"

describe "Home page" do
  describe "GET #index" do
    it "renders the new temlpate" do
      create_and_login_user
      get "/"

      expect(response).to render_template(:index)
      expect(response.body).to include("Ответы")
    end
  end
end
