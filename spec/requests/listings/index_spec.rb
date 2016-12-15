require "rails_helper"

describe "Listings" do
  describe "GET #index" do
    context "Real Estate" do
      context "listings/real-estate" do
        it "renders index temlpate" do
          get "/listings/real-estate"

          expect(response).to render_template(:index)
        end
      end

      context "category=leasing&kind=real-estate" do
        it "renders index temlpate" do
          get "/listings?category=leasing&kind=real-estate"

          expect(response).to render_template(:index)
        end
      end

      context "category=renting&kind=real-estate" do
        it "renders index temlpate" do
          get "/listings?category=renting&kind=real-estate"

          expect(response).to render_template(:index)
        end
      end
    end

    context "Jobs" do
      context "listings/jobs" do
        it "renders index temlpate" do
          get "/listings/jobs"

          expect(response).to render_template(:index)
        end
      end

      context "listings?category=wanted&kind=jobs" do
        it "renders index temlpate" do
          get "/listings?category=wanted&kind=jobs"

          expect(response).to render_template(:index)
        end
      end

      context "listings?category=seeking&kind=jobs" do
        it "renders index temlpate" do
          get "/listings?category=seeking&kind=jobs"

          expect(response).to render_template(:index)
        end
      end
    end

    context "Sales" do
      context "/listings/sales" do
        it "renders index temlpate" do
          get "/listings/sales"

          expect(response).to render_template(:index)
        end
      end

      context "/listings?category=buying&kind=sales" do
        it "renders index temlpate" do
          get "/listings?category=buying&kind=sales"

          expect(response).to render_template(:index)
        end
      end

      context "/listings?category=giving&kind=sales" do
        it "renders index temlpate" do
          get "/listings?category=giving&kind=sales"

          expect(response).to render_template(:index)
        end
      end
    end

    context "Services" do
      context "/listings/services" do
        it "renders index temlpate" do
          get "/listings/services"

          expect(response).to render_template(:index)
        end
      end
    end
  end

  describe "GET #show" do
    it "renders show template with listing" do
      listing = create :listing

      get "/listings/#{listing.id}"

      expect(response).to render_template(:show)
      expect(response.body).to include(listing.title)
    end
  end
end
