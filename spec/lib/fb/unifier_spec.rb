require "rails_helper"

describe Fb::Unifier do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }

  describe "#unified" do
    it "returns formatted post" do
      group = { kind: "real-estate",
                state_id: 43,
                city_id: 24_757 }
      item = HashWithIndifferentAccess.new(
        attachments: [],
        from: { name: "Marianna Sumina", id: "101" },
        message: "У нас на работе есть вакансия",
        created_time: 5.minutes.ago
      )

      atts = double(Fb::Attachments)
      allow(Fb::Attachments).to(receive(:new))
                            .with(item[:attachments])
                            .and_return(atts)
      allow(atts).to receive(:attachments)

      result = Fb::Unifier.new(item, group).unified

      kind = group[:kind].to_sym
      expected_attrs = {
        kind: group[:kind],
        category: KINDS[kind][:categories].first,
        subcategory: KINDS[kind][:subcategories].first,
        text: item[:message],
        state_id: group[:state_id],
        city_id: group[:city_id],
        user_id: 1,
        fb: "https://www.facebook.com/#{item[:from][:id]}",
        created_at: 5.minutes.ago
      }
      expect(result[:attributes]).to eq expected_attrs
      expect(Fb::Attachments).to have_received(:new).with(item[:attachments])
      expect(atts).to have_received(:attachments)
    end
  end
end
