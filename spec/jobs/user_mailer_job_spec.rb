require "rails_helper"

describe UserMailerJob do
  it "sends welcome_email to user" do
    user = build_stubbed(:user)
    mailer = double("UserMailer")
    allow(User).to receive(:find).with(user.id).and_return(user)
    allow(UserMailer).to receive(:welcome_email).with(user).and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    UserMailerJob.perform_async(user.id)
    UserMailerJob.drain

    expect(User).to have_received(:find).with(user.id)
    expect(UserMailer).to have_received(:welcome_email).with(user)
    expect(mailer).to have_received(:deliver_now)
  end
end
