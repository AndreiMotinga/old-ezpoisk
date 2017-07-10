require "rails_helper"

describe QuestionsController do
  describe "GET #index" do
    xit "renders the index template and returns answered questions" do
      question = create :question

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:questions).size).to eq 1
      expect(assigns(:questions).first).to eq question
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @question" do
      sign_in(create(:user))
      question = create(:question)
      create :answer, question: question

     get :show, params: { id: question.slug }

      expect(response).to render_template(:show)
      # expect(assigns(:question)).to eq question
      # expect(response.body).to match answer.text
    end
  end

  describe "GET #new" do
    context "user signed in" do
      it "renders the new template and assigns @question" do
        sign_in(create(:user))

        get :new

        expect(response).to render_template(:new)
        expect(assigns(:question)).to be_a_new(Question)
      end
    end
  end

  describe "POST #create" do
    it "creates question" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:question)

      post :create, params: { question: attrs }
      question = assigns(:question)

      expect(response).to redirect_to(question)
      expect(question.title).to eq attrs[:title] + "?"
      expect(question.text).to eq attrs[:text]
      expect(question.user).to eq @user
    end
  end
end
