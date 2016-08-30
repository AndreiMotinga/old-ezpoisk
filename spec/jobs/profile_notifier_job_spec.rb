require "rails_helper"

describe ProfileNotifierJob do
  it "sends welcome_email to user" do
    user = build_stubbed(:user)
    mailer = double("ProfileMailer")
    allow(User).to receive(:find).with(user.id).and_return(user)
    allow(ProfileMailer).to receive(:ten_visitors).with(user).and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    ProfileNotifierJob.perform_async(user.id)
    ProfileNotifierJob.drain

    expect(User).to have_received(:find).with(user.id)
    expect(ProfileMailer).to have_received(:ten_visitors).with(user)
    expect(mailer).to have_received(:deliver_now)
  end
end
