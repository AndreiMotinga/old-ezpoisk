require "rails_helper"

describe ListingsNotifierJob do
  it "sends email to proper email" do
    rp = build_stubbed(:listing)
    mailer = double("ListingsMailer")
    allow(RePrivate).to receive(:find_by_id).with(rp.id).and_return(rp)
    allow(ListingsMailer).to receive(:ten_visits).with(rp).and_return(mailer)
    allow(mailer).to receive(:deliver_now)

    ListingsNotifierJob.perform_async(rp.id, "RePrivate")
    ListingsNotifierJob.drain

    expect(RePrivate).to have_received(:find_by_id).with(rp.id)
    expect(ListingsMailer).to have_received(:ten_visits).with(rp)
    expect(mailer).to have_received(:deliver_now)
  end
end
