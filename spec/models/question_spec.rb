require "rails_helper"

describe Question do
  it { should belong_to(:user) }
  it { should have_many(:answers) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(10) }

  describe ".search" do
    it "retruns all records if term blank" do
      2.times { create(:question) }

      expect(Question.search('').count).to eq 2
    end

    context "with one word" do
      it 'returns records' do
        create :question, title: "Как поехать в США"
        q2 = create :question, title: "Что такое хорошо?"

        qs = Question.search("такое")

        expect(qs.count).to eq 1
        expect(qs.first).to eq q2
      end
    end

    context "with numbers" do
      it 'returns records' do
        q1 = create :question, title: "Что случилось в 1989?"
        create :question, title: "Как поехать в США"

        qs = Question.search("1989")

        expect(qs.count).to eq 1
        expect(qs.first).to eq q1
      end
    end
  end

  describe ".unanswered" do
    it "returns only questions where is at least one answer" do
      unanswered = create :question
      answered = create :question
      create :answer, question: answered

      qs = Question.unanswered

      expect(qs.size).to eq 1
      expect(qs.first).to eq unanswered
    end
  end

  # PRIVATE

  describe "private verify_title" do
    it "appends ? when it's not there" do
      question = build :question, title: "Foo bar baz"
      question.save
      expect(question.title).to eq "Foo bar baz?"
    end

    it "appends doesn't append ? when it's there" do
      question = build :question, title: "Foo bar baz?"
      question.save
      expect(question.title).to eq "Foo bar baz?"
    end

    it "capitalizes title" do
      question = build :question, title: "foo bar baz?"
      question.save
      expect(question.title).to eq "Foo bar baz?"
    end
  end

  describe "private update_cached_tags" do
    it "udpates cached_tags on question" do
      question = create :question, title: "foo bar baz?", tag_list: ["работа"]

      question.tag_list = %w[работа недвижимость]
      question.save

      expect(question.cached_tags).to eq "работа,недвижимость"
    end

    it "udpates cached_tags on questions answers" do
      question = create :question, title: "foo bar baz?", tag_list: ["работа"]
      answer = create :answer, question: question

      question.tag_list = %w[работа недвижимость]
      question.save

      answer.reload
      expect(answer.cached_tags).to eq "работа,недвижимость"
      expect(answer.tag_list).to match %w[работа недвижимость]
    end
  end
end
