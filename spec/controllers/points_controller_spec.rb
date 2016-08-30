require "rails_helper"

describe PointsController do
  describe "POST #create" do
    context "user thanks himself" do
      it "doesn't create anything" do
        user = create :user
        sign_in(user)

        post :create, params: { user_id: user.id }, format: :js

        expect(Point.count).to eq 0
      end
    end

    context "user thanks someone" do
      it "creates point" do
        author = create :user
        sign_in(author)
        user = create :user

        post :create, params: { user_id: user.id }, format: :js

        point = Point.first
        expect(Point.count).to eq 1
        expect(point.user_id).to eq user.id
        expect(point.author.id).to eq author.id
      end
    end
  end
end
