require "rails_helper"

describe QuestionMailer do
  describe "new_activity" do
    it "delivers welcome email to user" do
      question = build_stubbed(:question)
      email = "foo@bar.com"
      QuestionMailer.new_activity(question, email).deliver_now

      delivery = deliveries.first

      expect(deliveries.count).to eq 1
      expect(delivery.to).to eq [email]
      expect(delivery.from).to eq ["ez@ezpoisk.com"]
      expect(delivery.subject).to eq question.title
    end
  end
end
