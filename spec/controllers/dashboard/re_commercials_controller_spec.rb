require "rails_helper"

describe Dashboard::ReCommercialsController do
  before { sign_in(@user = create(:user)) }

  describe "GET #index" do
    it "renders the index template and returns user's @re_commercials" do
      2.times { create :re_commercial, user: @user }
      create :re_commercial # different user

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:re_commercials).size).to be 2
    end
  end

  describe "GET #new" do
    it "renders the new temlpate and assigns @re_commercials" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_commercial)).to be_a_new(ReCommercial)
    end
  end

  describe "GET #edit" do
    it "renders the edit template and assigns @re_commercial" do
      re_commercial = create :re_commercial, user: @user

      get :edit, id: re_commercial.id

      expect(response).to render_template(:edit)
      expect(assigns(:re_commercial)).to eq re_commercial
    end

    it "only shows record that belongs to user" do
      re_commercial = create :re_commercial
      create :re_commercial, user: @user

      get :edit, id: re_commercial.id

      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST #create" do
    it "creates new record" do
      attrs = attrs_with_state_and_city(:re_commercial)

      post :create, re_commercial: attrs
      re_commercial = assigns(:re_commercial)

      expect(response).to redirect_to(
        edit_dashboard_re_commercial_path(re_commercial)
      )
      expect(re_commercial.street).to eq attrs[:street]
      expect(re_commercial.category).to eq attrs[:category]
      expect(re_commercial.post_type).to eq attrs[:post_type]
      expect(re_commercial.description).to eq attrs[:description]
      expect(re_commercial.price).to eq attrs[:price]
      expect(re_commercial.space).to eq attrs[:space]
      expect(re_commercial.active).to eq attrs[:active]
      expect(re_commercial.city.id).to eq attrs[:city_id]
      expect(re_commercial.state.id).to eq attrs[:state_id]
      expect(re_commercial.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates the record" do
      re_commercial = create :re_commercial, user: @user
      attrs = attrs_with_state_and_city(:re_commercial)

      put :update, id: re_commercial.id, re_commercial: attrs

      expect(response)
        .to redirect_to(edit_dashboard_re_commercial_path(re_commercial))
      re_commercial.reload

      expect(re_commercial.street).to eq attrs[:street]
      expect(re_commercial.category).to eq attrs[:category]
      expect(re_commercial.post_type).to eq attrs[:post_type]
      expect(re_commercial.description).to eq attrs[:description]
      expect(re_commercial.price).to eq attrs[:price]
      expect(re_commercial.space).to eq attrs[:space]
      expect(re_commercial.active).to eq attrs[:active]
      expect(re_commercial.city.id).to eq attrs[:city_id]
      expect(re_commercial.state.id).to eq attrs[:state_id]
      expect(re_commercial.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      re_commercial = create(:re_commercial, user: @user)

      delete :destroy, id: re_commercial.id

      expect(response).to redirect_to(dashboard_re_commercials_path)
      expect(ReCommercial.count).to be 0
    end
  end
end
