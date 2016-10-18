require "rails_helper"

describe CommentNotifierJob do
  it "sends welcome_email to user" do
    email = "foo@bar.com"
    comment = build_stubbed(:comment)
    allow(Comment).to receive(:find).with(comment.id).and_return(comment)
    allow(comment).to receive(:emails).and_return([email])
    mailer = double("CommentMailer")
    allow(CommentMailer).to receive(:new_comment).with(comment, email)
                                                 .and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    CommentNotifierJob.perform_async(comment.id)
    CommentNotifierJob.drain

    expect(Comment).to have_received(:find).with(comment.id)
    expect(CommentMailer).to have_received(:new_comment).with(comment, email)
    expect(mailer).to have_received(:deliver_now)
  end
end
