require "rails_helper"

describe RePrivate do
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :post_type }
  it { should validate_presence_of :rooms }
  it { should validate_presence_of :duration }

  it { should belong_to(:user) }
  it { should belong_to(:state) }
  it { should belong_to(:city) }
  it { should have_many(:pictures).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:favorites).dependent(:destroy) }

  describe "#logo" do
    it "returns logo image of the re_private" do
      rp = create(:re_private)
      Picture.create(imageable_type: "RePrivate", imageable_id: rp.id)
      logo = Picture.create(imageable_type: "RePrivate",
                            imageable_id: rp.id,
                            logo: true)

      expect(rp.cached_logo).to eq logo
    end
  end

  describe "#logo_url" do
    it "return missing-small.png url when logo isn't set" do
      re_private = create(:re_private)

      expect(re_private.logo_url)
        .to eq "https://s3.amazonaws.com/ezpoisk/missing-small.png"
    end
  end

  describe "#address" do
    it "returns address string" do
      re_private = build :re_private,
                         state_id: 33,
                         city_id: 18_031,
                         zip: 11_229,
                         street: "1970 East 18th"

      address = "1970 East 18th Astoria New York 11229"

      expect(re_private.address).to eq address
    end
  end

  describe "#edit_link" do
    it "returns path to edit record" do
      re_private = build_stubbed(:re_private)
      edit_path = url_helpers.edit_dashboard_re_private_path(re_private)

      result = re_private.edit_link

      expect(result).to eq edit_path
    end
  end

  describe "#notification_email" do
    it "" do
      rp = build :re_private
      expect(rp.notification_email).to eq rp.email
    end

    it "" do
      user = create :user
      rp = build :re_private, email: nil, user: user
      expect(rp.notification_email).to eq user.email
    end
  end
end
