require "rails_helper"

describe PointNotifierJob do
  it "sends welcome_email to user" do
    user = build_stubbed(:user)
    author = build_stubbed(:user)
    mailer = double("ProfileMailer")
    allow(User).to receive(:find).with(user.id).and_return(user)
    allow(User).to receive(:find).with(author.id).and_return(author)
    allow(ProfileMailer).to receive(:thanked).with(user, author).and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    PointNotifierJob.perform_async(user.id, author.id)
    PointNotifierJob.drain

    expect(User).to have_received(:find).with(user.id)
    expect(User).to have_received(:find).with(author.id)
    expect(ProfileMailer).to have_received(:thanked).with(user, author)
    expect(mailer).to have_received(:deliver_now)
  end
end
