require "rails_helper"

describe Dashboard::SalesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #new" do
    it "renders the new template and assigns @sale" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:sale)).to be_a_new(Sale)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      sale = create :sale
      create :sale, user: @user

      expect { get :edit, id: sale.id}
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates sale" do
      attrs = attributes_for(:sale)

      post :create, sale: attrs
      sale = assigns(:sale)

      expect(response).to redirect_to(
        edit_dashboard_sale_path(sale)
      )
      expect(sale.title).to eq attrs[:title]
      expect(sale.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates sale" do
      sale = create(:sale, user: @user)
      attrs = attributes_for(:sale)

      put :update, id: sale.id, sale: attrs
      updated_sale = assigns(:sale)

      expect(response).to redirect_to(
        edit_dashboard_sale_path(updated_sale)
      )
      expect(updated_sale.title).to eq attrs[:title]
      expect(updated_sale.phone).to eq attrs[:phone]
      expect(updated_sale.email).to eq attrs[:email]
      expect(updated_sale.description).to eq attrs[:description]
      expect(updated_sale.active).to eq attrs[:active]

      expect(updated_sale.city_id).to eq attrs[:city_id]
      expect(updated_sale.state_id).to eq attrs[:state_id]
      expect(updated_sale.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sale = create(:sale, user: @user)

      delete :destroy, id: sale.id

      expect(response).to redirect_to(dashboard_path)
      expect(Sale.count).to be 0
    end
  end
end
