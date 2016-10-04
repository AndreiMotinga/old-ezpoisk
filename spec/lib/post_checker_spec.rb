require "rails_helper"

describe PostChecker do
  describe "#cool?" do
    it "returns false if post is older than a week" do
      rec = { date: 8.day.ago }
      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if post is too short" do
      rec = { date: 1.day.ago, text: "too short" }
      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if post with similar text already exists" do
      job = create :job
      rec = { date: 1.day.ago, text: job.text }

      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if post is a response" do
      rec = { date: 1.day.ago, text: "[Andrei,] rfr lrkf?" }

      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if there is a fresh vk post from this user" do
      job = create :job
      rec = { date: 1.day.ago, text: job.text, vk: job.vk }

      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if there is a fresh fb post from this user" do
      job = create :job
      rec = { date: 1.day.ago, text: job.text, fb: job.fb }

      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end

    it "returns false if post contains blocked words" do
      rec = { date: 1.day.ago, text: "Russian America ищет друзей" }
      result = PostChecker.new("Job", rec).cool?

      expect(result).to be_falsy
    end
  end
end