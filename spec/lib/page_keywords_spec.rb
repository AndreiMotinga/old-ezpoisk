require "spec_helper"

describe PageKeywords do
  describe ".from_params" do
    it "returns hash" do
      expect(PageKeywords.from_params({})).to be_instance_of Hash
    end

    it "sets state" do
      prms = { state: "new-york" }
      result = PageKeywords.from_params(prms)
      expect(result[:state]).to eq "new-york"
    end

    it "sets city" do
      prms = { city: "brooklyn" }
      result = PageKeywords.from_params(prms)
      expect(result[:city]).to eq "brooklyn"
    end

    context "sets tags" do
      it "tags is array" do
        result = PageKeywords.from_params({})
        expect(result[:tags]).to be_instance_of Array
      end

      it "doesn't include nils" do
        result = PageKeywords.from_params({})
        expect(result[:tags]).to_not include(nil)
      end

      it "is flat" do
        prms = { kind: "услуги", subcategory: "строительство--ремонт"}
        result = PageKeywords.from_params(prms)
        expect(result[:tags].size).to eq 3
      end

      it "from kind" do
        prms = { kind: "работа" }
        result = PageKeywords.from_params(prms)
        expect(result[:tags]).to include("работа")
      end

      it "from category" do
        prms = { category: "квартира" }
        result = PageKeywords.from_params(prms)
        expect(result[:tags]).to include("квартира")
      end

      it "from subcategory" do
        prms = { category: "требуется" }
        result = PageKeywords.from_params(prms)
        expect(result[:tags]).to include("требуется")
      end
    end
  end
end
