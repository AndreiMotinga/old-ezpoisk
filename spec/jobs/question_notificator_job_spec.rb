require "rails_helper"

describe QuestionNotificatorJob do
  it "sends 'new_activity' emails to question subscribers" do
    question = build_stubbed(:question)
    emails = ["foo@test.com", "bar@test.com"]
    allow(Question).to receive(:find).with(question.id).and_return(question)
    allow(question).to receive(:subscribers_emails).and_return(emails)

    QuestionNotificatorJob.perform_async(question.id)
    QuestionNotificatorJob.drain
    result = ActionMailer::Base.deliveries.count

    expect(result).to eq 2
  end
end
