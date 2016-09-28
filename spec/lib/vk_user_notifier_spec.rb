require "rails_helper"

describe VkUserNotifier do
  before { VkUserNotifier.vk_reset }

  context "shouldn't send message" do
    it "when history between users exists" do
      job = create :job, vk: "123"
      st = stub_history(job.vk)

      VkUserNotifier.new(job).notify

      expect(st).to have_been_requested
    end
  end

  context "sending messages" do
    it "sends message" do
      job = create :job, vk: "123"
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_history(job.vk)
      st = stub_successful_sending(job.vk, msg)

      VkUserNotifier.new(job).notify

      expect(st).to have_been_requested
    end
  end

  context "new token" do
    it "uses new token in case of error" do
      job = create :job, vk: "123"
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_history(job.vk)
      st = stub_failed_sending(job.vk, msg)
      history = stub_empty_history(job.vk, ENV["VK_TITOV_TOKEN"])
      new_st = stub_successful_sending(job.vk, msg, ENV["VK_TITOV_TOKEN"])

      VkUserNotifier.new(job).notify

      expect(st).to have_been_requested
      expect(history).to have_been_requested
      expect(new_st).to have_been_requested
    end

    it "uses new third token in case of second error" do
      job = create :job, vk: "123"
      msg = "test message"
      allow(Message).to receive(:message).with(job).and_return(msg)
      stub_empty_history(job.vk)
      stub_empty_history(job.vk, ENV["VK_TITOV_TOKEN"]) # other admin user
      stub_empty_history(job.vk, ENV["VK_OLEG_TOKEN"]) # other admin user
      new_st = stub_successful_sending(job.vk, msg, ENV["VK_TITOV_TOKEN"])
      first  = stub_failed_sending(job.vk, msg, ENV["VK_ANDREI_TOKEN"])
      second = stub_failed_sending(job.vk, msg, ENV["VK_TITOV_TOKEN"])
      third = stub_successful_sending(job.vk, msg, ENV["VK_OLEG_TOKEN"])

      VkUserNotifier.new(job).notify

      expect(first).to have_been_requested
      expect(second).to have_been_requested
      expect(third).to have_been_requested
    end
  end
end

def stub_failed_sending(user_id, msg, token = ENV["VK_ANDREI_TOKEN"])
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
    .with(body: { message: msg, user_id: user_id })
    .to_return(status: 200, body: body)
end

def stub_successful_sending(user_id, msg, token = ENV["VK_ANDREI_TOKEN"])
  body = '{"response": 4431}'
  url = "https://api.vk.com/method/messages.send?access_token=#{token}"
  stub_request(:post, url)
    .with(body: { message: msg, user_id: user_id })
    .to_return(status: 200, body: body)
end

def stub_empty_history(user_id, token = ENV["VK_ANDREI_TOKEN"])
  url = "https://api.vk.com/method/messages.getHistory?access_token=#{token}"
  body = '{"response":[0]}'
  stub_request(:post, url)
    .with(body: { user_id: user_id })
    .to_return(status: 200, body: body)
end

def stub_history(user_id, token = ENV["VK_ANDREI_TOKEN"])
  body = '{"response":[1]}' # not 0, meaning there are messages
  url = "https://api.vk.com/method/messages.getHistory?access_token=#{token}"
  stub_request(:post, url)
    .with(body: { user_id: user_id })
    .to_return(status: 200, body: body)
end
