require "rails_helper"

describe Dashboard::JobsController do
  describe "GET #new" do
    it "renders the new template and assigns @job" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:job)).to be_a_new(Job)
    end
  end

  describe "GET #edit" do
    context "user logged in" do
      it "only shows record that belongs to user" do
        sign_in(@user = create(:user))
        job = create :job
        prms = { id: job.id }

        expect { get :edit, params: prms }
          .to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "with token" do
      it "renders page" do
        job = create :job

        get :edit, params: { id: job.id, token: job.token }

        expect(response).to render_template(:edit)
        expect(assigns(:job)).to eq job
      end
    end
  end

  describe "POST #create" do
    context "user logged in" do
      it "creates job" do
        sign_in(@user = create(:user))
        attrs = attributes_for(:job)

        post :create, params: { job: attrs }
        job = assigns(:job)

        expect(response).to redirect_to(
          edit_dashboard_job_path(job)
        )
        expect(job.title).to eq attrs[:title]
        expect(job.user).to eq @user
        expect(flash[:notice]).to eq I18n.t(:post_saved)

        entry = Entry.last
        expect(Entry.count).to eq 1
        expect(entry.enterable_id).to eq job.id
        expect(entry.enterable_type).to eq job.class.to_s
        expect(entry.user_id).to eq @user.id

        expect(Subscription.count).to eq 1
      end
    end

    context "user not logged but" do
      it "creates job and redirects with token" do
        attrs = attributes_for(:job)

        post :create, params: { job: attrs }
        job = assigns(:job)

        expect(response).to redirect_to(
          edit_dashboard_job_path(job, token: job.token)
        )
        expect(job.user).to be nil
        notice = I18n.t(:post_saved_wr) + " #{job.edit_url_with_token}"
        expect(flash[:notice]).to eq notice
      end
    end
  end

  describe "PUT #update" do
    context "user logged in" do
      it "updates job" do
        sign_in(@user = create(:user))
        job = create(:job, user: @user)
        attrs = attributes_for(:job)

        put :update, params: { id: job.id, job: attrs }
        updated_agency = assigns(:job)

        expect(response).to redirect_to(
          edit_dashboard_job_path(updated_agency)
        )
        expect(updated_agency.title).to eq attrs[:title]
        expect(updated_agency.phone).to eq attrs[:phone]
        expect(updated_agency.email).to eq attrs[:email]
        expect(updated_agency.description).to eq attrs[:description]
        expect(updated_agency.active).to eq attrs[:active]

        expect(updated_agency.city_id).to eq attrs[:city_id]
        expect(updated_agency.state_id).to eq attrs[:state_id]
        expect(updated_agency.user).to eq @user
      end
    end

    context "user not logged but uses token" do
      it "updates the record" do
        job = create :job
        attrs = attributes_for(:job, title: job.title)

        put :update, params: {
          id: job.id, job: attrs, token: job.token
        }

        expect(response).to redirect_to(
          edit_dashboard_job_path(job, token: job.token)
        )
        job.reload

        expect(job.street).to eq attrs[:street]
        expect(flash[:notice]).to eq I18n.t(:post_saved)
      end
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
      job = create(:job, user: @user)
      job.subscriptions.create(user: @user)

      delete :destroy, params: { id: job.id }

      expect(response).to redirect_to(dashboard_path)
      expect(Job.count).to be 0
      expect(Entry.count).to be 0
      expect(Subscription.count).to be 0
    end
  end

  context "with token" do
    it "removes record and entry" do
      job = create :job

      delete :destroy, params: { id: job.id, token: job.token }

      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq I18n.t(:post_removed)
    end
  end
end
