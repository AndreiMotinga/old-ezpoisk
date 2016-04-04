require "rails_helper"

describe QuestionsController do
  describe "GET #index" do
    it "renders the index template and returns answered questions" do
      question = create :question
      answer = create :answer, question: question

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:questions).size).to eq 1
      expect(assigns(:questions).first).to eq question
    end
  end

  describe "GET #unanswered" do
    it "renders the index template and returns unanswered questions" do
      sign_in(create(:user))
      answered = create :question
      answer = create :answer, question: answered
      unanswered = create :question

      get :unanswered

      expect(response).to render_template(:unanswered)
      expect(assigns(:questions).size).to eq 1
      expect(assigns(:questions).first).to eq unanswered
    end
  end

  describe "GET @show" do
    it "renders the show template and assigns @question" do
      sign_in(create(:user))
      question = create(:question)
      create :answer, question: question

     get :show, id: question.slug

      expect(response).to render_template(:show)
      # expect(assigns(:question)).to eq question
      # expect(response.body).to match answer.text
    end
  end

  describe "GET #new" do
    context "user is not signed in" do
      it "redirects to sing in page" do
        get :new

        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      it "renders the new template and assigns @question" do
        sign_in(create(:user))

        get :new

        expect(response).to render_template(:new)
        expect(assigns(:question)).to be_a_new(Question)
      end
    end
  end

  describe "GET #edit" do
    context "user edits his question" do
      it "render edit template and assign question" do
        sign_in(@user = create(:user))
        question = create :question, user: @user

        get :edit, id: question.slug

        expect(response).to render_template(:edit)
        expect(assigns(:question)).to eq question
      end
    end

    context "user tries to edit someone elses question" do
      it "redirects" do
        sign_in(create(:user))
        question = create :question

        get :edit, id: question.slug

        expect(response).to redirect_to(questions_path)
      end
    end
  end

  describe "POST #create" do
    it "creates question" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:question)

      post :create, question: attrs
      question = assigns(:question)

      expect(response).to redirect_to(question)
      expect(question.title).to eq attrs[:title]
      expect(question.text).to eq attrs[:text]
      expect(question.user).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates question" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      attrs = attributes_for(:question)

      put :update, id: question.slug, question: attrs
      updated_q = assigns(:question)

      expect(response).to redirect_to(updated_q)
      expect(updated_q.title).to eq attrs[:title]
      expect(updated_q.text).to eq attrs[:text]
      expect(updated_q.user).to eq @user
    end
  end
end
