require "rails_helper"

describe Dashboard::ReCommercialsController do
  describe "GET #new" do
    it "renders the new temlpate and assigns @re_commercials" do
      sign_in(@user = create(:user))

      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_commercial)).to be_a_new(ReCommercial)
    end

    context "with token" do
      it "renders page" do
        re_commercial = create :re_commercial

        get :edit, params: { id: re_commercial.id, token: re_commercial.token }

        expect(response).to render_template(:edit)
        expect(assigns(:re_commercial)).to eq re_commercial
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit template and assigns @re_commercial" do
      sign_in(@user = create(:user))
      re_commercial = create :re_commercial, user: @user

      get :edit, params: { id: re_commercial.id }

      expect(response).to render_template(:edit)
      expect(assigns(:re_commercial)).to eq re_commercial
    end

    it "only shows record that belongs to user" do
      sign_in(@user = create(:user))
      re_commercial = create :re_commercial
      create :re_commercial, user: @user

      expect { get :edit, params: { id: re_commercial.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

  describe "POST #create" do
    it "creates new record and entry" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:re_commercial)

      post :create, params: { re_commercial: attrs }
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

      entry = Entry.last
      expect(Entry.count).to eq 1
      expect(entry.enterable_id).to eq re_commercial.id
      expect(entry.enterable_type).to eq re_commercial.class.to_s
      expect(entry.user_id).to eq @user.id

      expect(Subscription.count).to eq 1
    end
  end

  describe "PUT #update" do
    it "updates the record" do
      sign_in(@user = create(:user))
      re_commercial = create :re_commercial, user: @user
      attrs = attributes_for(:re_commercial)

      put :update, params: { id: re_commercial.id, re_commercial: attrs }

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

    context "with token" do
      it "updates the record" do
        rc = create :re_commercial
        attrs = attributes_for(:re_commercial)

        put :update, params: {
          id: rc.id, re_commercial: attrs, token: rc.token
        }

        expect(response).to redirect_to(
          edit_dashboard_re_commercial_path(rc, token: rc.token)
        )
        rc.reload

        expect(rc.street).to eq attrs[:street]
        expect(flash[:notice]).to eq I18n.t(:post_saved)
      end
    end
  end

  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
      re_commercial = create(:re_commercial, user: @user)
      re_commercial.subscriptions.create(user: @user)

      delete :destroy, params: { id: re_commercial.id }

      expect(response).to redirect_to(dashboard_path)
      expect(ReCommercial.count).to be 0
      expect(Entry.count).to be 0
      expect(Subscription.count).to be 0
    end
  end

    context "with token" do
      it "removes record and entry" do
        re_commercial = create :re_commercial

        delete :destroy, params: { id: re_commercial.id,
                                   token: re_commercial.token }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq I18n.t(:post_removed)
      end
    end
end
