require "rails_helper"

describe Media::Validator do
  describe "#clean?" do
    it "returns false if post is older than 1 hour" do
      rec = { created_at: 2.hours.ago }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes short posts" do
      rec = { created_at: 1.minute.ago, text: "too short" }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes posts that are responses to other users" do
      rec = { created_at: 1.minute.ago, text: "[Andrei,1908] sup?" }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes it if there is an active vk post from this user" do
      listing = create :listing, active: true
      rec = { created_at: 1.minute.ago, text: listing.text, vk: listing.vk }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes it if there is a fresh fb post from this user" do
      listing = create :listing, active: true
      rec = { created_at: 1.minute.ago, text: listing.text, fb: listing.fb }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    xit "returns false if post contains blocked words" do
      rec = { created_at: 1.minute.ago, text: "Russian America т.. " }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "returns true when all is ok" do
      rec = { created_at: 1.minute.ago, text: "Сдаю квартиру" }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_truthy
    end
  end
end
