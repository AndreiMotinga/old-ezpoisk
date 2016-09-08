require "rails_helper"

describe Dashboard::PartnersController do
  before do
    sign_in(@user = create(:user))
    Sidekiq::Worker.clear_all
  end

  describe "GET #index" do
    it "returns user's partners" do
      2.times { create :partner, user: @user }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:partners).size).to eq 2
    end
  end

  describe "GET #new" do
    it "renders the new temlpate and assigns @partner" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:partner)).to be_a_new(Partner)
    end
  end

  describe "GET #edit" do
    it "renders the edit template and assigns @partner" do
      partner = create :partner, user: @user

      get :edit, params: { id: partner.id }

      expect(response).to render_template(:edit)
      expect(assigns(:partner)).to eq partner
    end

    it "only shows record that belongs to user" do
      partner = create :partner
      create :partner, user: @user

      expect { get :edit, params: { id: partner.id } }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates new record" do
      attrs = attributes_for(:partner)

      post :create, params: { partner: attrs }
      partner = assigns(:partner)

      expect(response).to redirect_to(dashboard_partners_path)
      expect(partner.title).to eq attrs[:title]
      expect(partner.text).to eq attrs[:text]
      expect(partner.position).to eq attrs[:position]
      expect(partner.budget).to eq attrs[:budget]
      expect(partner.phone).to eq attrs[:phone]
      expect(partner.email).to eq attrs[:email]
      expect(partner.approved).to eq false
      expect(partner.clicks).to eq 0
      expect(partner.impressions_count).to eq 0
      expect(partner.user).to eq @user

      expect(flash[:notice]).to eq I18n.t(:we_contact_shortly)
      expect(SlackNotifierJob.jobs.size).to eq 1
    end
  end

  describe "PUT #update" do
    it "updates the record" do
      partner = create :partner, approved: true, user: @user
      attrs = attributes_for(:partner)

      put :update, params: { id: partner.id, partner: attrs }

      expect(response).to redirect_to(dashboard_partners_path)
      partner.reload

      expect(partner.title).to eq attrs[:title]
      expect(partner.approved).to eq false
      expect(flash[:notice]).to eq I18n.t(:we_contact_shortly)
      expect(SlackNotifierJob.jobs.size).to eq 1
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      partner = create(:partner, user: @user)

      delete :destroy, params: { id: partner.id }

      expect(response).to redirect_to(dashboard_partners_path)
      expect(Partner.count).to eq 0
    end
  end
end
