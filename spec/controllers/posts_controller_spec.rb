require "rails_helper"

describe PostsController do
  describe "POST #create" do
    it "creates karma" do
      sign_in(@user = create(:user))
      attrs = attributes_for(:post)

      post :create, params: { post: attrs }
      karma = Karma.last

      expect(karma.karmable_type).to eq "Post"
      expect(karma.kind).to eq "created"
      expect(karma.user).to eq @user
      expect(karma.giver).to eq @user
    end
  end
end
