require "rails_helper"

describe TextChecker do
  describe "#post_from_user_is_fresh?" do
    it "returns true if user has a fresh post" do
      job = create :job

      checker = TextChecker.new("Job", job.text, job.vk)

      expect(checker.post_from_user_is_fresh?).to eq true
    end
  end
end
