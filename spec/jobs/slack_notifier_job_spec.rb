require "rails_helper"

describe SlackNotifierJob do
  it "sends messsages to slack" do
    sale = build_stubbed(:sale)
    allow(Sale).to receive(:find_by_id).with(sale.id).and_return(sale)
    allow(Ez).to receive(:notify_about).with(sale, "new")

    SlackNotifierJob.perform_async(sale.id, sale.class.to_s)
    SlackNotifierJob.drain

    expect(Sale).to have_received(:find_by_id).with(sale.id)
    expect(Ez).to have_received(:notify_about).with(sale, "new")
  end
end
