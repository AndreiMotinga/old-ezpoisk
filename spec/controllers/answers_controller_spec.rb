require "rails_helper"

describe AnswersController do
  describe "GET #index" do
    it "renders the index template and returns answers" do
      2.times { create :answer }

      get :index

      expect(response).to render_template(:index)
      expect(assigns(:answers).size).to eq 2
    end
  end

  describe "POST #create" do
    it "creates answer and touches entry" do
      sign_in(@user = create(:user))
      question = create :question
      entry = question.create_entry(user: @user, updated_at: 1.month.ago)
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      post :create, params: { answer: attrs }
      answer = assigns(:answer)

      expect(response).to redirect_to(question)
      expect(answer.text).to eq attrs[:text]
      expect(answer.user).to eq @user

      entry.reload
      expect(entry.updated_at).to eq Time.zone.now
    end

    it "subscribes answer's author for answer's question" do
      sign_in(@user = create(:user))
      question = create :question
      question.create_entry(user: @user)
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      post :create, params: { answer: attrs }

      expect(Subscription.count).to eq 1
    end
  end

  describe "PUT #update" do
    it "updates answer" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      put :update, params: { id: answer.id, answer: attrs }
      updated_a = assigns(:answer)

      expect(response).to redirect_to(question)
      expect(updated_a.text).to eq attrs[:text]
      expect(updated_a.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      delete :destroy, params: { id: answer.id }

      expect(response).to redirect_to(question)
      expect(Answer.count).to be 0
    end
  end

  describe "xhr PUT #upvote" do
    it "increases score by 1" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      put :upvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq 1
    end
  end

  describe "xhr PUT #downvote" do
    it "increases score by 1" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      put :downvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq -1
    end
  end

  describe "xhr PUT #unvote" do
    it "increases score by 1" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      # instead of creating vote properly
      put :downvote, xhr: true, params: { id: answer.id }

      put :unvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq 0
    end
  end
end
