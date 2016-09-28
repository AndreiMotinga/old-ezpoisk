require "rails_helper"

describe VkUserNotifier do
  before { VkUserNotifier.vk_reset }

  context "shouldn't send message" do
    it "doesn't request history if there is no record or if it's inactive" do
      st = stub_history
      VkUserNotifier.new(1929, 1, "Job")
      expect(st).to_not have_been_requested
    end

    it "when history between users exists" do
      job = create :job
      st = stub_history

      VkUserNotifier.new(1929, job.id, job.class.to_s).notify

      expect(st).to have_been_requested
    end
  end

  context "sending messages" do
    it "sends message" do
      job = create :job
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_hostory
      st = stub_successful_sending(msg)

      VkUserNotifier.new(1929, job.id, job.class.to_s).notify

      expect(st).to have_been_requested
    end
  end

  context "new token" do
    it "uses new token in case of error" do
      job = create :job
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_hostory
      st = stub_failed_sending(msg)
      history = stub_empty_hostory(ENV["VK_TITOV_TOKEN"]) # other admin user
      new_st = stub_successful_sending(msg, ENV["VK_TITOV_TOKEN"])

      VkUserNotifier.new(1929, job.id, job.class.to_s).notify

      expect(st).to have_been_requested
      expect(history).to have_been_requested
      expect(new_st).to have_been_requested
    end

    it "uses new third token in case of second error" do
      job = create :job
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_hostory
      stub_empty_hostory(ENV["VK_TITOV_TOKEN"]) # other admin user
      stub_empty_hostory(ENV["VK_OLEG_TOKEN"]) # other admin user
      new_st = stub_successful_sending(msg, ENV["VK_TITOV_TOKEN"])
      first  = stub_failed_sending(msg, ENV["VK_ANDREI_TOKEN"])
      second = stub_failed_sending(msg, ENV["VK_TITOV_TOKEN"])
      third = stub_successful_sending(msg, ENV["VK_OLEG_TOKEN"])

      VkUserNotifier.new(1929, job.id, job.class.to_s).notify

      expect(first).to have_been_requested
      expect(second).to have_been_requested
      expect(third).to have_been_requested
    end
  end
end

def stub_failed_sending(msg, token = ENV["VK_ANDREI_TOKEN"])
  body = '{
    "error":{
      "error_code":100,
      "error_msg":"One of the parameters specified was missing",
      "request_params": [
        {"key":"oauth","value":"1"},
        {"key":"method","value":"messages.send"},
        {"key":"user_id","value":"123"}
      ]
    }}'
  url = "https://api.vk.com/method/messages.send?access_token=#{token}"
  stub_request(:post, url)
    .with(body: { message: msg, user_id: "1929" })
    .to_return(status: 200, body: body)
end

def stub_successful_sending(msg, token = ENV["VK_ANDREI_TOKEN"])
  body = '{"response": 4431}'
  url = "https://api.vk.com/method/messages.send?access_token=#{token}"
  stub_request(:post, url)
    .with(body: { message: msg, user_id: "1929" })
    .to_return(status: 200, body: body)
end

def stub_empty_hostory(token = ENV["VK_ANDREI_TOKEN"])
  url = "https://api.vk.com/method/messages.getHistory?access_token=#{token}"
  body = '{"response":[0]}'
  stub_request(:post, url)
    .with(body: { user_id: "1929" })
    .to_return(status: 200, body: body)
end

def stub_history(token = ENV["VK_ANDREI_TOKEN"])
  body = '{"response":[1]}' # not 0, meaning there are messages
  url = "https://api.vk.com/method/messages.getHistory?access_token=#{token}"
  stub_request(:post, url)
    .with(body: { user_id: "1929" })
    .to_return(status: 200, body: body)
end
