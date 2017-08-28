require "rails_helper"

describe AnswersController do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  describe "POST #create" do
    it "creates answer" do
      sign_in(@user = create(:user))
      question = create :question, updated_at: 1.day.ago
      attrs = attributes_for(:answer)
      attrs[:question_id] = question.id

      post :create, params: { answer: attrs }
      answer = assigns(:answer)
      question.reload

      expect(response).to redirect_to(answer)
      expect(answer.text).to eq attrs[:text]
      expect(answer.user).to eq @user

      expect(question.updated_at).to eq Time.zone.now
      expect(question.answers_count).to eq 1

      karma = Karma.last
      expect(karma.karmable_type).to eq "Answer"
      expect(karma.kind).to eq "created"
      expect(karma.user).to eq @user
      expect(karma.giver).to eq @user
    end
  end

  describe "PUT #update" do
    it "updates answer" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)
      attrs = attributes_for(:answer, title: answer.title)
      attrs[:question_id] = question.id

      put :update, params: { id: answer.id, answer: attrs }
      updated_a = assigns(:answer)

      expect(response).to redirect_to(answer_path(answer))
      expect(updated_a.text).to eq attrs[:text]
      expect(updated_a.user).to eq @user
    end
  end

  describe "DELETE #destroy" do
    it "removes record" do
      sign_in(@user = create(:user))
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)
      create :karma, user: @user, karmable: answer, kind: "created"

      delete :destroy, params: { id: answer.id }

      expect(response).to redirect_to(question)
      expect(Answer.count).to be 0
      expect(Karma.count).to eq 0
    end
  end

  describe "xhr PUT #upvote" do
    it "increases score by 1" do
      sign_in(@voter = create(:user))
      @user = create(:user)
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user,
                                                   created_at: 1.day.ago)

      put :upvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq 1
      expect(answer.updated_at).to eq Time.zone.now

      karma = Karma.last
      expect(karma.karmable_type).to eq "Answer"
      expect(karma.kind).to eq "upvoted"
      expect(karma.user).to eq @user
      expect(karma.giver).to eq @voter
    end
  end

  describe "xhr PUT #downvote" do
    it "increases score by 1" do
      sign_in(@voter = create(:user))
      @user = create(:user)
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)
      create :karma, karmable: answer, user: @user, giver: @voter, kind: "upvoted"

      put :downvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq -1
      expect(answer.updated_at).to eq Time.zone.now
      expect(Karma.count).to eq 0
    end
  end

  describe "xhr PUT #unvote" do
    it "increases score by 1" do
      sign_in(@voter = create(:user))
      @user = create(:user)
      question = create(:question, user: @user)
      answer = create(:answer, question: question, user: @user)
      create :karma, karmable: answer, user: @user, giver: @voter, kind: "upvoted"

      put :unvote, xhr: true, params: { id: answer.id }

      answer.reload
      expect(answer.score).to eq 0
      expect(answer.updated_at).to eq Time.zone.now
      expect(Karma.count).to eq 0
    end
  end
end
