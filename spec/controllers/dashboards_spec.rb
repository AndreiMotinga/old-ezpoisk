require "rails_helper"

describe DashboardsController do
  describe "#show" do
    context "users is not signed in " do
      it "redirects to sign in page" do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "users is signed in" do
      it "displays dashboard" do
        user = create :user
        sign_in user
        get :show

        expect(response).to be_success
      end
    end
  end
end
