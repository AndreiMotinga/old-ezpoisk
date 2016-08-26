require "rails_helper"

describe FacebookNotifierJob do
  it "posts to facebook" do
    re_private = create(:re_private)
    stub_facebook_notifier(re_private)

    FacebookNotifierJob.perform_async(re_private.id, "RePrivate")
    FacebookNotifierJob.drain

    expect(FacebookNotifier).to have_received(:post).with(re_private)
  end

  def stub_facebook_notifier(record)
    allow(FacebookNotifier)
      .to receive(:post)
      .with(record)
  end
end
