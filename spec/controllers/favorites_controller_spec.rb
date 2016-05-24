require "rails_helper"

describe FavoritesController do
  describe "POST create" do
    context "creates favorite" do
      context "favorite doesn't exist yet" do
        it "creates favorite" do
          user = create(:user)
          sign_in(user)
          re_private = create(:re_private)

          post :create, favorite: favorite_attrs(re_private)
          result = user.favorites.first

          expect(result.user_id).to eq user.id
          expect(result.favorable_id).to eq re_private.id
          expect(result.favorable_type).to eq re_private.class.to_s
          expect(result.hidden).to eq false
        end
      end

      context "favorite already exists" do
        it "destroys favorite" do
          user = create(:user)
          sign_in(user)
          re_private = create(:re_private)
          create(:favorite,
                 user_id: user.id,
                 favorable_id: re_private.id,
                 favorable_type: re_private.class.to_s,
                 saved: true,
                 hidden: false)

          post :create, favorite: favorite_attrs(re_private)
          result = user.favorites.count

          expect(result).to eq 0
        end
      end
    end

    context "creates hidden" do
      context "hidden doesn't exist yet" do
        it "creates hidden" do
          user = create(:user)
          sign_in(user)
          re_private = create(:re_private)
          attrs = {
            favorable_id: re_private.id,
            favorable_type: re_private.class,
            favorite: false,
            hidden: true
          }

          post :create, favorite: attrs
          result = user.favorites.first

          expect(result.user_id).to eq user.id
          expect(result.favorable_id).to eq re_private.id
          expect(result.favorable_type).to eq re_private.class.to_s
          expect(result.hidden).to eq true
        end
      end

      context "favorite already exists" do
        it "destroys favorite" do
          user = create(:user)
          sign_in(user)
          re_private = create(:re_private)
          create(
            :favorite,
            user_id: user.id,
            favorable_id: re_private.id,
            favorable_type: re_private.class.to_s,
            saved: false,
            hidden: true
          )
          attrs = {
            favorable_id: re_private.id,
            favorable_type: re_private.class,
            saved: false,
            hidden: true
          }

          post :create, favorite: attrs
          result = user.favorites.count

          expect(result).to eq 0
        end
      end
    end
  end

  def favorite_attrs(record)
    {
      favorable_id: record.id,
      favorable_type: record.class,
      saved: true,
      hidden: false
    }
  end
end
