require "rails_helper"

describe TextChecker do
  describe "#cool?" do
    it "returns false if post is too short" do
      result = TextChecker.new("Job", "too short", "foo", "bar").cool?

      expect(result).to be_falsy
    end
    it "returns false if post with similar text already exists" do
      job = create :job

      result = TextChecker.new("Job", job.text, "foo", "bar").cool?

      expect(result).to be_falsy
    end

    it "returns false if post is a response" do
      job = create :job, text: "[Andrei,] rfr lrkf?"

      result = TextChecker.new("Job", job.text, "foo", "bar").cool?

      expect(result).to be_falsy
    end

    it "returns false if there is a fresh vk post from this user" do
      job = create :job

      result = TextChecker.new("Job", "foo", job.vk, "bar").cool?

      expect(result).to be_falsy
    end

    it "returns false if there is a fresh fb post from this user" do
      job = create :job

      result = TextChecker.new("Job", "foo", "foo", job.fb).cool?

      expect(result).to be_falsy
    end

    it "returns false if post contains blocked words" do
      result = TextChecker.new("Job", "Russian America", "foo", "bar").cool?

      expect(result).to be_falsy
    end
  end
end
