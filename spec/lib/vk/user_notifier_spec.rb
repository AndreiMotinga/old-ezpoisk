require "rails_helper"

describe Vk::UserNotifier do
  before do
    Vk::UserNotifier.vk_reset
    @id = "4010889"
    @job = create :job, vk: "foo/#{@id}"
    @msg = "test message"
    allow(SocialMessage).to receive(:msg).with(@job).and_return(@msg)
  end

  context "sending messages" do
    it "sends message" do
      st = stub_successful_sending(@id, @msg)

      Vk::UserNotifier.new(@job)

      expect(st).to have_been_requested
    end
  end

  it "uses new token in case of error" do
    failed = stub_failed_sending(@id, @msg)
    success = stub_successful_sending(@id, @msg, ENV["VK_OLEG_TOKEN"])

    Vk::UserNotifier.new(@job)

    expect(failed).to have_been_requested
    expect(success).to have_been_requested
  end

  it "uses new third token in case of second error" do
    first  = stub_failed_sending(@id, @msg, ENV["VK_EZ_TOKEN"])
    second = stub_failed_sending(@id, @msg, ENV["VK_OLEG_TOKEN"])
    third = stub_successful_sending(@id, @msg, ENV["VK_ANDREI_TOKEN"])

    Vk::UserNotifier.new(@job)

    expect(first).to have_been_requested
    expect(second).to have_been_requested
    expect(third).to have_been_requested
  end

  def stub_failed_sending(user_id, msg, token = ENV["VK_EZ_TOKEN"])
    body = '{
    "error":{
      "error_code":100,
      "error_msg":"One of the parameters specified was missing",
      "request_params": [
        {"key":"oauth","value":"1"},
        {"key":"method","value":"messages.send"},
        {"key":"user_id","value":"4010889"}
      ]
    }}'
    url = "https://api.vk.com/method/messages.send?access_token=#{token}"
    stub_request(:post, url)
      .with(body: { message: msg, user_id: user_id, "v": "5.33" })
      .to_return(status: 200, body: body)
  end

  def stub_successful_sending(user_id, msg, token = ENV["VK_EZ_TOKEN"])
    body = '{"response": 4431}'
    url = "https://api.vk.com/method/messages.send?access_token=#{token}"
    stub_request(:post, url)
      .with(body: { message: msg, user_id: user_id, "v": "5.33" })
      .to_return(status: 200, body: body)
  end
end

