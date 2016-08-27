require "rails_helper"

describe Dashboard::SalesController do
  describe "GET #new" do
    it "renders the new template and assigns @sale" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:sale)).to be_a_new(Sale)
    end
  end

  describe "GET #edit" do
    it "only shows record that belongs to user" do
      sign_in(@user = create(:user))
      sale = create :sale
      create :sale, user: @user

      expect { get :edit, params: { id: sale.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    context "with token" do
      it "renders page" do
        sale = create :sale

        get :edit, params: { id: sale.id, token: sale.token }

        expect(response).to render_template(:edit)
        expect(assigns(:sale)).to eq sale
      end
    end
  end

  describe "POST #create" do
    context "user logged in" do
      it "creates sale" do
        sign_in(@user = create(:user))
        attrs = attributes_for(:sale)

        post :create, params: { sale: attrs }
        sale = assigns(:sale)

        expect(response).to redirect_to(
          edit_dashboard_sale_path(sale)
        )
        expect(sale.title).to eq attrs[:title]
        expect(sale.user).to eq @user
        expect(flash[:notice]).to eq I18n.t(:post_saved)

        expect(GeocodeJob.jobs.size).to eq 1
        expect(FacebookNotifierJob.jobs.size).to eq 1
        expect(VkNotifierJob.jobs.size).to eq 1

        entry = Entry.last
        expect(Entry.count).to eq 1
        expect(entry.enterable_id).to eq sale.id
        expect(entry.enterable_type).to eq sale.class.to_s
        expect(entry.user_id).to eq @user.id

        expect(Subscription.count).to eq 1
      end
    end

    context "user not logged" do
      it "creates sale reidrects to edit with token" do
        attrs = attributes_for(:sale)

        post :create, params: { sale: attrs }
        sale = assigns(:sale)

        expect(response).to redirect_to(
          edit_dashboard_sale_path(sale, token: sale.token)
        )
        expect(sale.title).to eq attrs[:title]
        expect(sale.user).to be nil
        notice = I18n.t(:post_saved_wr) + " #{sale.edit_url_with_token}"
        expect(flash[:notice]).to eq notice
      end
    end
  end

  describe "PUT #update" do
    it "updates sale" do
      sign_in(@user = create(:user))
      sale = create(:sale, user: @user)
      attrs = attributes_for(:sale)

      put :update, params: { id: sale.id, sale: attrs }
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

    context "with token" do
      it "updates the record" do
        sale = create :sale
        attrs = attributes_for(:sale, title: sale.title)

        put :update, params: {
          id: sale.id, sale: attrs, token: sale.token
        }

        expect(response).to redirect_to(
          edit_dashboard_sale_path(sale, token: sale.token)
        )
        sale.reload

        expect(sale.street).to eq attrs[:street]
        expect(flash[:notice]).to eq I18n.t(:post_saved)
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
      sale = create(:sale, user: @user)
      sale.subscriptions.create(user: @user)

      delete :destroy, params: { id: sale.id }

      expect(response).to redirect_to(dashboard_path)
      expect(Sale.count).to be 0
      expect(Entry.count).to be 0
      expect(Subscription.count).to be 0
    end
  end

    context "with token" do
      it "removes record and entry" do
        sale = create :sale

        delete :destroy, params: { id: sale.id, token: sale.token }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq I18n.t(:post_removed)
      end
    end
end
