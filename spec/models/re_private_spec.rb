require "rails_helper"

describe RePrivate do
  it { should validate_presence_of :price }
  it { should validate_presence_of :post_type }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :street }

  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }
  it { should have_many(:pictures).dependent(:destroy) }

  describe "#logo" do
    it "returns logo image of the re_private" do
      re_private = create(:re_private)
      create(:picture, :re_private, imageable_id: re_private.id)
      logo = create(:picture,
                    :re_private,
                    imageable_id: re_private.id,
                    logo: true)

      expect(re_private.logo).to eq logo
    end
  end

  describe "#logo_url" do
    it "returns logo url with appropriate style when logo is set" do
      re_private = create(:re_private)
      create(:picture, :re_private, imageable_id: re_private.id)
      logo = create(:picture,
                    :re_private,
                    imageable_id: re_private.id,
                    logo: true)

      expect(re_private.logo_url(:thumb)).to eq logo.image.url(:thumb)
      expect(re_private.logo_url(:medium)).to eq logo.image.url(:medium)
    end

    it "return missing.png url when logo isn't set" do
      re_private = create(:re_private)

      expect(re_private.logo_url(:thumb)).to eq "missing.png"
    end
  end

  describe "#show_description" do
    it "uses default string when doesn't have description" do
      re_private = create :re_private, description: nil
      expect(re_private.show_description).to eq I18n.t(:no_description)
    end
  end

  describe "#address" do
    it "returns address string" do
      state = create(:state, name: "New York")
      city = create(:city, state: state, name: "Brooklyn")
      re_private = build :re_private,
                         state: state,
                         city: city,
                         zip: 11_229,
                         street: "1970 East 18th"
      address = "1970 East 18th, Brooklyn New York, 11229"
      expect(re_private.address).to eq address
    end
  end
end
