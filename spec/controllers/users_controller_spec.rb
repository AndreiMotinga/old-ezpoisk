require "rails_helper"

describe UsersController do
  describe "#show" do
    it "is success and assigns @user" do
      user = create :user

      get :show, params: { id: user.id }

      expect(assigns(:user)).to be_a User
      expect(response).to be_success
      expect(ProfileNotifierJob.jobs.size).to eq 0
    end
  end
end
