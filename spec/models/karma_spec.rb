require 'rails_helper'

RSpec.describe Karma, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:karmable) }

  # PRIVATE

  describe "private #set_amount" do
    it "sets amount before saving" do
      q = create :question
      karma = build :karma, karmable: q, kind: "created"

      karma.save
      karma.reload

      expect(karma.amount).to eq 20
    end
  end
end
