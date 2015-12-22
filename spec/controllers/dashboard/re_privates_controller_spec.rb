require "rails_helper"

describe Dashboard::RePrivatesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and returns user's @re_privates" do
      2.times { create :re_private, user: @user }
      create :re_private # different user

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:re_privates).size).to be 2
    end
  end

  describe "GET #new" do
    it "renders the new temlpate and assigns @re_private" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_private)).to be_a_new(RePrivate)
    end
  end

  describe "GET #show" do
    it "renders the show template and assigns @re_private" do
      re_private = create :re_private

      get :show, id: re_private.id

      expect(response).to render_template(:show)
      expect(assigns(:re_private)).to eq re_private
    end
  end

  describe "GET #edit" do
    it "renders the edit template and assigns @re_private" do
      re_private = create :re_private

      get :edit, id: re_private.id

      expect(response).to render_template(:edit)
      expect(assigns(:re_private)).to eq re_private
    end
  end

  describe "POST #create" do
    it "creates new record" do
      attrs = re_private_attributes(user: @user)

      post :create, re_private: attrs
      re_private = assigns(:re_private)

      expect(response).to redirect_to(
        dashboard_re_private_path(re_private)
      )
      expect(re_private.street).to eq attrs[:street]
      expect(re_private.user).to eq @user
      expect(re_private.city.id).to eq attrs[:city_id]
      expect(re_private.state.id).to eq attrs[:state_id]
    end
  end

  describe "PUT #update" do
    it "updates the record" do
      re_private = create :re_private
      attrs = attributes_for(:re_private)

      put :update, id: re_private.id, re_private: attrs

      expect(response).to redirect_to(dashboard_re_private_path(re_private))
      re_private.reload

      expect(re_private.street).to eq attrs[:street]
      expect(re_private.phone).to eq attrs[:phone]
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      re_private = create(:re_private)

      delete :destroy, id: re_private.id

      expect(response).to redirect_to(dashboard_re_privates_path)
      expect(RePrivate.count).to be 0
    end
  end
end

def re_private_attributes(user:)
  attrs = attributes_for(:re_private)
  attrs[:state_id] = create(:state).id
  attrs[:city_id] = create(:city).id
  attrs[:user_id] = user.id
  attrs
end
