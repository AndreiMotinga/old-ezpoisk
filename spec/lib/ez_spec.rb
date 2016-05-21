require "rails_helper"

describe Ez do
  describe ".notifier" do
    it "returns Slack::Notifier" do
      notifier = Ez.notifier

      expect(notifier).to be_instance_of Slack::Notifier
    end
  end

  describe ".ping" do
    it "sends message to slack" do
      stub_post = stub_request(:post, ENV["SLACK_URL"])

      Ez.ping("foo")

      expect(stub_post)
        .to have_requested(:post, ENV["SLACK_URL"])
        .with(body: payload)
    end
  end

  describe ".notify about" do
    it "notifies channel of a record" do
      stub_post = stub_request(:post, ENV["SLACK_URL"])
      re_private = build_stubbed(:re_private)
      allow(StringForSlack)
        .to receive(:string_for)
        .with(re_private)
        .and_return("foo")

      Ez.notify_about(re_private)

      expect(stub_post)
        .to have_requested(:post, ENV["SLACK_URL"])
        .with(body: payload)
    end
  end

  def payload
    { payload: "{\"text\":\"foo\"}" }
  end
end
