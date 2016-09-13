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

    context "profile is visted for the 10th time" do
      it "enques ProfileNotifierJob" do
        user = create :user, impressions_count: 9

        get :show, params: { id: user.id }

        expect(ProfileNotifierJob.jobs.size).to eq 1
      end
    end

    context "profile is visited by user himself" do
      it "doesn't increment impressions_count" do
        user = create :user
        sign_in(user)

        get :show, params: { id: user.id }

        user = assigns(:user)
        expect(user).to be_a User
        expect(response).to be_success
        expect(user.impressions_count).to eq 0
        expect(ProfileNotifierJob.jobs.size).to eq 0
      end
    end
  end
end
