require "rails_helper"

describe Dashboard::ReFinancesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #new" do
    it "renders the new template and assigns @re_finance" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_finance)).to be_a_new(ReFinance)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      re_finance = create :re_finance
      create :re_finance, user: @user


      expect{ get :edit, id: re_finance.id }.
        to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates re_finance" do
      attrs = attrs_with_state_and_city(:re_finance)

      post :create, re_finance: attrs
      re_finance = assigns(:re_finance)

      expect(response).to redirect_to(
        edit_dashboard_re_finance_path(re_finance)
      )
      expect(re_finance.title).to eq attrs[:title]
      expect(re_finance.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates re_finance" do
      re_finance = create(:re_finance, user: @user)
      attrs = attrs_with_state_and_city(:re_finance)

      put :update, id: re_finance.id,  re_finance: attrs
      updated_finance = assigns(:re_finance)

      expect(response).to redirect_to(
        edit_dashboard_re_finance_path(updated_finance)
      )
      expect(updated_finance.title).to eq attrs[:title]
      expect(updated_finance.street).to eq attrs[:street]
      expect(updated_finance.phone).to eq attrs[:phone]
      expect(updated_finance.email).to eq attrs[:email]
      expect(updated_finance.description).to eq attrs[:description]
      expect(updated_finance.active).to eq attrs[:active]

      expect(updated_finance.city_id).to eq attrs[:city_id]
      expect(updated_finance.state_id).to eq attrs[:state_id]
      expect(updated_finance.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      re_finance = create(:re_finance, user: @user)

      delete :destroy, id: re_finance.id

      expect(response).to redirect_to(dashboard_path)
      expect(ReFinance.count).to be 0
    end
  end
end
