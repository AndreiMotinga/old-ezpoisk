require "rails_helper"

describe DeactivationsController do
  describe "POST #create" do
    it "creates answer and entry" do
      sign_in(@user = create(:user))
      rp = create :re_private
      attrs = attributes_for :deactivation,
                             deactivatable_id: rp.id,
                             deactivatable_type: rp.class.to_s

      post :create, params: { deactivation: attrs }

      expect(response).to be_success
      dea = Deactivation.first
      expect(dea.deactivatable_id).to_not eq nil
      expect(dea.deactivatable_type).to eq "RePrivate"
      expect(Deactivation.count).to eq 1
    end

    context "user already voted" do
      it "does nothing" do
        sign_in(@user = create(:user))
        rp = create :re_private
        create :deactivation, user_id: @user.id,
                              deactivatable_id: rp.id,
                              deactivatable_type: rp.class.to_s
        attrs = attributes_for :deactivation,
                               deactivatable_id: rp.id,
                               deactivatable_type: rp.class.to_s

        post :create, params: { deactivation: attrs }

        expect(Deactivation.count).to eq 1
      end
    end

    it "deactivates record when it was marked inactive more then 5 times" do
      sign_in(@user = create(:user))
      rp = create :re_private
      5.times { create :deactivation,
                       user_id: (create(:user)).id,
                       deactivatable_id: rp.id,
                       deactivatable_type: rp.class.to_s }
      attrs = attributes_for :deactivation,
                             deactivatable_id: rp.id,
                             deactivatable_type: rp.class.to_s

      post :create, params: { deactivation: attrs }

      expect(Deactivation.count).to eq 6
      rp.reload
      expect(rp.active).to eq false
    end
  end
end
