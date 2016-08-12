require "rails_helper"

describe Question do
  it { should belong_to(:user) }
  it { should have_many(:answers) }

  it { should validate_presence_of(:title) }

  describe ".by_keyword" do
    it "retruns all records if keyword blank" do
      2.times { create(:question) }

      expect(Question.by_keyword('').count).to eq 2
    end

    context "with one word" do
      it 'returns records' do
        q1 = create :question, title: "Как поехать в США"
        q2 = create :question, title: "Что такое хорошо?"

        qs = Question.by_keyword("что")

        expect(qs.count).to eq 1
        expect(qs.first).to eq q2
      end
    end

    context "with 2 words" do
      it 'returns records' do
        q1 = create :question, title: "Как поехать в США"
        q2 = create :question, title: "Что такое хорошо?"

        qs = Question.by_keyword("хорош тако")

        expect(qs.count).to eq 1
        expect(qs.first).to eq q2
      end
    end

    context "with numbers" do
      it 'returns records' do
        q1 = create :question, title: "Что случилось в 1989?"
        q2 = create :question, title: "Как поехать в США"

        qs = Question.by_keyword("1989")

        expect(qs.count).to eq 1
        expect(qs.first).to eq q1
      end
    end
  end

  describe ".unanswered" do
    it "returns only questions where is at least one answer" do
      unanswered = create :question
      answered = create :question
      answer = create :answer, question: answered

      qs = Question.unanswered

      expect(qs.size).to eq 1
      expect(qs.first).to eq unanswered
    end
  end
end
