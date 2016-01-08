require "rails_helper"

describe ReAgency do
  it { should validate_presence_of :title }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :user_id }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
  it { should have_many(:pictures).dependent(:destroy) }

  describe "#show_description" do
    it "uses default string when doesn't have description" do
      re_agency = create :re_agency, description: ''
      expect(re_agency.show_description).to eq "Автор не предоставил описание"
    end
  end
end
