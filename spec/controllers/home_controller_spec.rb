require "rails_helper"

describe HomeController do
  describe "#index" do
    it "renders home page" do
      get :index
      expect(response).to be_success
    end
  end
end
