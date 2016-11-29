# todo fix test, mdoel?
require "rails_helper"

describe Fb::GroupLoader do
  describe "#data" do
    it "imports data" do
      group = { "id": 1_614_363_378_884_490, "model": "RePrivate",
                "state_id": 43, "city_id": 24_757 }
      stub_request_to(group)
      unifier = double(Fb::Unifier)
      item = double("item")
      allow(Fb::Unifier)
        .to receive(:new)
        .and_return(unifier)
        .exactly(res_size).times
      allow(unifier)
        .to receive(:unified)
        .and_return(item)
        .exactly(res_size).times

      result = Fb::GroupLoader.new(group).data

      expect(result).to be_kind_of Array
      expect(result.size).to eq res_size
      expect(Fb::Unifier)
        .to have_received(:new)
        .exactly(res_size).times
      expect(unifier)
        .to have_received(:unified)
        .exactly(res_size).times
    end
  end

  def stub_request_to(group)
    token = ENV["FB_TOKEN"]
    res = File.read("spec/support/fb_response.json")
    fields = "from,message,created_time,attachments"
    url = "https://graph.facebook.com/#{group[:id]}/feed?" \
      "access_token=#{token}&fields=#{fields}"
    stub_request(:get, url).to_return(body: res)
  end

  def res_size
    10
  end
end
