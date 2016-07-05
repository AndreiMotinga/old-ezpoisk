require "rails_helper"

describe AnswersController do
  describe "POST #create" do
    it "creates answer and touches entry" do
      sign_in(@user = create(:user))
      question = create :question, updated_at: 1.month.ago
      entry = question.create_entry(updated_at: question.updated_at)
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      post :create, answer: attrs
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
      question.create_entry
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      post :create, answer: attrs

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

      put :update, id: answer.id, answer: attrs
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

      delete :destroy, id: answer.id

      expect(response).to redirect_to(question)
      expect(Answer.count).to be 0
    end
  end

  describe "xhr PUT #upvote" do
    it "increases score by 1" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      xhr :put, :upvote, id: answer.id

      answer.reload
      expect(answer.score).to eq 1
    end
  end

  describe "xhr PUT #downvote" do
    it "increases score by 1" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)

      xhr :put, :downvote, id: answer.id

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
      xhr :put, :downvote, id: answer.id

      xhr :put, :unvote, id: answer.id

      answer.reload
      expect(answer.score).to eq 0
    end
  end
end
