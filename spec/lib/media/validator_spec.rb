require "rails_helper"

describe Media::Validator do
  describe "#clean?" do
    it "returns false if post is older than 1 hour" do
      rec = { date: 2.hours.ago, text: "foo bar baz", model: "Job" }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes short posts" do
      rec = { date: 1.day.ago, text: "too short", model: "Job" }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "returns false if post with similar text already exists" do
      job = create :job, created_at: 8.days.ago
      good = { date: Time.zone.now, text: job.text, model: "Job" }
      fresh_job = create :job, created_at: 1.day.ago
      bad = { date: Time.zone.now, text: fresh_job.text, model: "Job" }

      valid = Media::Validator.new(good).valid?
      not_valid = Media::Validator.new(bad).valid?

      expect(valid).to be_truthy
      expect(not_valid).to be_falsy
    end

    it "removes posts that are responses to other users" do
      rec = { date: 1.day.ago, text: "[Andrei,1908] sup?", model: "Job" }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes it if there is a fresh vk post from this user" do
      job = create :job
      rec = { date: 1.day.ago, text: job.text, vk: job.vk, model: "Job" }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "removes it if there is a fresh fb post from this user" do
      job = create :job
      rec = { date: 1.day.ago, text: job.text, fb: job.fb, model: "Job" }

      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end

    it "returns false if post contains blocked words" do
      rec = { date: 1.day.ago, text: "Russian America т.. ", model: "Job" }
      result = Media::Validator.new(rec).valid?

      expect(result).to be_falsy
    end
  end
end
