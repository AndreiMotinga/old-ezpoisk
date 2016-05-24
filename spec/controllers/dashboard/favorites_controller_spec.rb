require "rails_helper"

describe Dashboard::FavoritesController do
  describe "GET #index" do
    it "returns user's favorites" do
      user = create(:user)
      sign_in(user)
      re_private = create(:re_private)
      sale = create(:sale)
      [re_private, sale].each do |record|
        create(:favorite,
               :saved,
               user_id: user.id,
               favorable_id: record.id,
               favorable_type: record.class.to_s
              )
      end

      get :index
      result = assigns(:favorites)

      expect(response).to render_template(:index)
      expect(result).to match [re_private, sale]
    end
  end
end
