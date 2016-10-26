require "rails_helper"

describe Fb::Unifier do
  describe "#unified" do
    it "returns formatted post" do
      group = { id: 1_614_363_378_884_490,
                model: "RePrivate",
                state_id: 43,
                city_id: 24_757 }
      post = HashWithIndifferentAccess.new(
        from: { name: "Marianna Sumina", id: "101" },
        message: "У нас на работе есть вакансия",
        created_time: "2016-09-23T21:37:02+0000",
        id: "249106225164786_1151928844882515"
      )

      result = Fb::Unifier.new(post, group).unified

      expect(result[:date]).to eq post[:created_time]
      expect(result[:text]).to eq post[:message]
      expect(result[:vk]).to eq ""
      expect(result[:fb]).to eq "https://www.facebook.com/101"
    end
  end
end
