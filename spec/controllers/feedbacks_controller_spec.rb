require "rails_helper"

describe FeedbacksController do
  describe "GET #new" do
    it "renders new template and assigns @feedback" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:feedback)).to be_a_new(Feedback)
    end
  end

  describe "POST #create" do
    context "user is not logged in" do
      it "creates post" do
        attrs = attributes_for(:feedback)

        post :create, feedback: attrs
        feedback = Feedback.last

        expect(feedback.body).to eq attrs[:body]
        expect(feedback.name).to eq attrs[:name]
        expect(feedback.email).to eq attrs[:email]
      end
    end
  end
end
