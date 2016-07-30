require "rails_helper"

describe Dashboard::RePrivatesController do
  before { sign_in(@user = create(:user)) }

  describe "GET #new" do
    it "renders the new temlpate and assigns @re_private" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:re_private)).to be_a_new(RePrivate)
    end
  end

  describe "GET #edit" do
    it "renders the edit template and assigns @re_private" do
      re_private = create :re_private, user: @user

      get :edit, params: { id: re_private.id }

      expect(response).to render_template(:edit)
      expect(assigns(:re_private)).to eq re_private
    end

    it "only shows record that belongs to user" do
      re_private = create :re_private
      create :re_private, user: @user

      expect { get :edit, params: { id: re_private.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates new record and entry" do
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
      expect(flash[:notice]).to eq I18n.t(:post_saved)

      expect(GeocodeJob.jobs.size).to eq 1

      entry = Entry.last
      expect(Entry.count).to eq 1
      expect(entry.enterable_id).to eq re_private.id
      expect(entry.enterable_type).to eq re_private.class.to_s
      expect(entry.user_id).to eq @user.id
    end

    it "renders form and displays alert when record isn't saved" do
      attrs = attributes_for(:re_private, user: @user, state_id: nil)

      post :create, params: { re_private: attrs }

      expect(response).to render_template(:new)
      expect(flash[:alert]).to be_present
    end
  end

  describe "PUT #update" do
    it "updates the record" do
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

  describe "DELETE #destroy" do
    it "removes record and entry" do
      re_private = create(:re_private, user: @user)
      re_private.create_entry

      delete :destroy, params: { id: re_private.id }

      expect(response).to redirect_to(dashboard_path)
      expect(RePrivate.count).to eq 0
      expect(flash[:notice]).to eq I18n.t(:post_removed)
      expect(Entry.count).to eq 0
    end
  end
end
