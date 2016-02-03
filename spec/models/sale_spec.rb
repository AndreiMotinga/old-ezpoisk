require "rails_helper"

describe Sale do
  it { should validate_presence_of :title }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :category }

  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :user_id }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }

  it { should have_many(:pictures).dependent(:destroy) }

  describe "#address" do
    it "returns properly formatted address" do
      state = create :state, :alabama
      city = create :city, :brooklyn
      sale = create :sale,
                    state: state,
                    city: city,
                    zip: 123

      expect(sale.address).to eq "Brooklyn Alabama, 123"
    end
  end
end
