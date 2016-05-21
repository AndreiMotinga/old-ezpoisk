require "rails_helper"

describe Job do
  it { should validate_presence_of :title }
  it { should validate_presence_of :category }

  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :user_id }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }

  it { should have_many(:favorites).dependent(:destroy) }

  describe "address" do
    context "full string" do
      it "returns full address" do
        city = create(:city, name: "Brooklyn")
        job = build :job,
                     state_id: 32,
                     city: city,
                     zip: 11_229,
                     street: "1970 East 18th"
        address = "1970 East 18th Brooklyn New York, 11229"
        expect(job.address).to eq address
      end

      it "returns address without street" do
        city = create(:city, name: "Brooklyn")
        job = build :job,
                     state_id: 32,
                     city: city,
                     zip: 11_229,
                     street: ""
        address = "Brooklyn New York, 11229"
        expect(job.address).to eq address
      end

      it "returns address without street and zip" do
        city = create(:city, name: "Brooklyn")
        job = build :job,
                     state_id: 32,
                     city: city,
                     zip: 0,
                     street: ""
        address = "Brooklyn New York"
        expect(job.address).to eq address
      end
    end
  end
end
