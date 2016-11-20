require "rails_helper"

describe Vk::GroupLoader do
  it "imports data" do
    group = { "id": 2_258_194, "topic": 24_112_410,
              "model": "Job", "state_id": 33, "city_id": 17_880 }
    stub_request_to(group)
    unifier = double(Vk::Unifier)
    item = double("item")
    allow(Vk::Unifier)
      .to receive(:new)
      .and_return(unifier)
      .exactly(20).times
    allow(unifier)
      .to receive(:unified)
      .and_return(item)
      .exactly(20).times

    result = Vk::GroupLoader.new(group).data

    expect(result).to be_kind_of Array
    expect(result.size).to eq 20
    expect(Vk::Unifier)
      .to have_received(:new)
      .exactly(20).times
    expect(unifier)
      .to have_received(:unified)
      .exactly(20).times
  end

  def stub_request_to(grp)
    body = { group_id: grp[:id].to_s, sort: "desc",
             topic_id: grp[:topic].to_s, v: "5.33" }
    token = ENV["VK_YURA_TOKEN"]
    res = File.read("spec/support/vk_response.json")
    url = "https://api.vk.com/method/board.getComments?access_token=#{token}"
    stub_request(:post, url).with(body: body).to_return(body: res)
  end
end
