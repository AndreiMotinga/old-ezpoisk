require "rails_helper"

describe "Listings" do
  describe "GET #new" do
    context "user logged in" do
      it "renders the new temlpate" do
        create_and_login_user
        get "/dashboard/listings/new"

        expect(response).to render_template(:new)
      end
    end

    context "user not logged in" do
      it "renders the new temlpate" do
        get "/dashboard/listings/new"

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET #edit" do
    context "when user logged in" do
      it "renders the edit template" do
        user = create_and_login_user
        listing = create :listing, user: user

        get "/dashboard/listings/#{listing.id}/edit"

        expect(response).to render_template(:edit)
        expect(response.body).to include(listing.title)
      end

      it "only shows record that belongs to user" do
        create_and_login_user
        listing = create :listing

        expect { get "/dashboard/listings/#{listing.id}/edit" }
          .to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "user isn't logged in but uses token" do
      it "renders edit template" do
        listing = create :listing

        get "/dashboard/listings/#{listing.id}/edit?token=#{listing.token}"

        expect(response).to render_template(:edit)
        expect(response.body).to include(listing.title)
      end
    end
  end
end
