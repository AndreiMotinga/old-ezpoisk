require "rails_helper"

describe Dashboard::EditorsController do
  describe "GET #show" do
    context "user doesn't have permissions" do
      it "redirects to root_path" do
        sign_in(create(:user))
        user = create :user

        get :show, params: { id: user.id }
        expect(response).to redirect_to(root_path)
      end
    end

    it "assings @user, @answers" do
      sign_in(@user = create(:user))
      answer = create :answer, user: @user

      get :show, params: { id: @user.id }

      expect(response).to render_template(:show)
      expect(assigns(:user)).to eq @user
      expect(assigns(:answers)).to match_array([answer])
    end
  end
end
