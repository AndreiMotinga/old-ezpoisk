require "rails_helper"

describe ReCommercial do
  it { should validate_presence_of :post_type }
  it { should validate_presence_of :category }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :street }

  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  describe "#logo" do
    it "returns logo image of the re_commercial" do
      re_commercial = create(:re_commercial)
      create(:picture, :re_commercial, imageable_id: re_commercial.id)
      logo = create(:picture,
                    :re_commercial,
                    imageable_id: re_commercial.id,
                    logo: true)

      expect(re_commercial.logo).to eq logo
    end
  end


  describe "#logo_url" do
    it "returns logo url with appropriate style when logo is set" do
      re_commercial = create(:re_commercial)
      create(:picture, :re_commercial, imageable_id: re_commercial.id)
      logo = create(:picture,
                    :re_commercial,
                    imageable_id: re_commercial.id,
                    logo: true)

      expect(re_commercial.logo_url(:thumb)).to eq logo.image.url(:thumb)
      expect(re_commercial.logo_url(:medium)).to eq logo.image.url(:medium)
    end

    it "return missing.png url when logo isn't set" do
      re_commercial = create(:re_commercial)

      expect(re_commercial.logo_url(:thumb)).to eq "https://s3.amazonaws.com/ezpoisk/missing.png"
    end
  end

  describe "#address" do
    it "returns address string" do
      re_commercial = build :re_commercial,
                         state_id: 32,
                         city_id: 18_031,
                         zip: 11_229,
                         street: "1970 East 18th"
      address = "1970 East 18th Astoria New York, 11229"
      expect(re_commercial.address).to eq address
    end
  end

  describe "#edit_link" do
    it "returns path to edit record" do
      re_commercial = build_stubbed(:re_commercial)
      edit_path = url_helpers.edit_dashboard_re_commercial_path(re_commercial)

      result = re_commercial.edit_link

      expect(result).to eq edit_path
    end
  end
end
