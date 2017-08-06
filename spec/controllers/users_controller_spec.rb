require "rails_helper"

describe UsersController do
  describe "POST #create" do
      it "updates the record" do
        user = create :user
        sign_in(user)
        attrs = attributes_for(:user, state_id: 32, city_id: 18031)

        put :update, params: { id: user.id, user: attrs }

        expect(response).to redirect_to(edit_user_path user)
        expect(flash[:notice]).to eq I18n.t(:user_updated)
        user.reload

        expect(user.name).to eq attrs[:name]
        expect(user.state_slug).to eq "new-york"
        expect(user.city_slug).to eq "brooklyn"
        expect(GeocodeJob.jobs.size).to eq 1
      end
    end
  end
