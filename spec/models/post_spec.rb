require "rails_helper"

describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should belong_to(:user) }
  it { should have_many(:favorites).dependent(:destroy) }

  describe "#edit_link" do
    it "returns path to edit record" do
      post = build_stubbed(:post)
      edit_path = url_helpers.edit_dashboard_post_path(post)

      result = post.edit_link

      expect(result).to eq edit_path
    end
  end
end
