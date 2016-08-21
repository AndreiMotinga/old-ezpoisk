require "rails_helper"

describe Dashboard::RePrivatesController do
  describe "GET #new" do
    it "renders the new temlpate and assigns @re_private" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_private)).to be_a_new(RePrivate)
    end
  end

  describe "GET #edit" do
    context "user logged in" do
      it "renders the edit template and assigns @re_private" do
        sign_in(@user = create(:user))
        re_private = create :re_private, user: @user

        get :edit, params: { id: re_private.id }

        expect(response).to render_template(:edit)
        expect(assigns(:re_private)).to eq re_private
      end

      it "only shows record that belongs to user" do
        sign_in(@user = create(:user))
        re_private = create :re_private
        create :re_private, user: @user

        expect { get :edit, params: { id: re_private.id } }
          .to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "user isn't logged in but uses token" do
      it "renders page" do
        re_private = create :re_private

        get :edit, params: { id: re_private.id, token: re_private.token }

        expect(response).to render_template(:edit)
        expect(assigns(:re_private)).to eq re_private
      end
    end
  end

  describe "POST #create" do
    context "user logged in" do
      it "creates new record, entry, and subscription" do
        sign_in(@user = create(:user))
        attrs = attributes_for(:re_private)

        post :create, params: { re_private: attrs }
        re_private = assigns(:re_private)

        expect(response).to redirect_to(
          edit_dashboard_re_private_path(re_private)
        )
        expect(re_private.street).to eq attrs[:street]
        expect(re_private.user).to eq @user
        expect(re_private.city.id).to eq attrs[:city_id]
        expect(re_private.state.id).to eq attrs[:state_id]
        expect(re_private.category).to eq attrs[:category]
        expect(re_private.token).to_not eq nil
        expect(flash[:notice]).to eq I18n.t(:post_saved)

        expect(GeocodeJob.jobs.size).to eq 1

        entry = Entry.last
        expect(Entry.count).to eq 1
        expect(entry.enterable_id).to eq re_private.id
        expect(entry.enterable_type).to eq re_private.class.to_s
        expect(entry.user_id).to eq @user.id

        expect(Subscription.count).to eq 1
      end
    end

    context "user is not logged in" do
      it "creates new record and redirects with token" do
        attrs = attributes_for(:re_private)

        post :create, params: { re_private: attrs }
        re_private = assigns(:re_private)

        expect(response).to redirect_to(
          edit_dashboard_re_private_path(re_private, token: re_private.token)
        )

        expect(re_private.user).to be nil
        notice = I18n.t(:post_saved_wr) + " #{re_private.edit_url_with_token}"
        expect(flash[:notice]).to eq notice
      end
    end

    it "renders form and displays alert when record isn't saved" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:re_private, user: @user, state_id: nil)

      post :create, params: { re_private: attrs }

      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end
  end

  describe "PUT #update" do
    context "user logged in " do
      it "updates the record" do
        sign_in(@user = create(:user))
        re_private = create :re_private, user: @user
        attrs = attributes_for(:re_private)

        put :update, params: { id: re_private.id, re_private: attrs }

        expect(response).to redirect_to(edit_dashboard_re_private_path re_private)
        re_private.reload

        expect(re_private.street).to eq attrs[:street]
        expect(re_private.phone).to eq attrs[:phone]
        expect(flash[:notice]).to eq I18n.t(:post_saved)

        expect(GeocodeJob.jobs.size).to eq 1
      end
    end

    context "user not logged in but uses token" do
      it "updates the record" do
        re_private = create :re_private
        attrs = attributes_for(:re_private)

        put :update, params: {
          id: re_private.id, re_private: attrs, token: re_private.token
        }

        expect(response).to redirect_to(
          edit_dashboard_re_private_path(re_private, token: re_private.token)
        )
        re_private.reload

        expect(re_private.street).to eq attrs[:street]
        expect(flash[:notice]).to eq I18n.t(:post_saved)
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes record and entry" do
      sign_in(@user = create(:user))
      re_private = create(:re_private, user: @user)
      re_private.create_entry
      re_private.subscriptions.create(user: @user)

      delete :destroy, params: { id: re_private.id }

      expect(response).to redirect_to(dashboard_path)
      expect(RePrivate.count).to eq 0
      expect(flash[:notice]).to eq I18n.t(:post_removed)
      expect(Entry.count).to eq 0
      expect(Subscription.count).to eq 0
    end

    context "with token" do
      it "removes record and entry" do
        re_private = create :re_private

        delete :destroy, params: { id: re_private.id, token: re_private.token }

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq I18n.t(:post_removed)
      end
    end
  end
end
