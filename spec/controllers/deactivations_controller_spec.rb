# todo rethink this
require "rails_helper"

xdescribe DeactivationsController do
  describe "POST #create" do
    it "creates answer" do
      sign_in(@user = create(:user))
      rp = create :listing
      attrs = { deactivatable_id: rp.id, deactivatable_type: rp.class.to_s }

      post :create, params: { deactivation: attrs }

      expect(response).to be_success
      dea = Deactivation.first
      expect(dea.deactivatable_id).to_not eq nil
      expect(dea.deactivatable_type).to eq "Listing"
      expect(Deactivation.count).to eq 1
    end

    context "user already voted" do
      it "does nothing" do
        sign_in(@user = create(:user))
        rp = create :listing
        Deactivation.create(
          user_id: @user.id,
          deactivatable_id: rp.id,
          deactivatable_type: rp.class.to_s
        )
        attrs = { deactivatable_id: rp.id, deactivatable_type: rp.class.name }

        post :create, params: { deactivation: attrs }

        expect(Deactivation.count).to eq 1
      end
    end

    it "deactivates record when it was marked inactive more then 5 times" do
      sign_in(@user = create(:user))
      rp = create :listing, deactivations_count: 5
      attrs = { deactivatable_id: rp.id, deactivatable_type: rp.class.name }

      post :create, params: { deactivation: attrs }

      rp.reload
      expect(rp.deactivations_count).to eq 6
      expect(rp.active).to eq false
    end
  end
end
