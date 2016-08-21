require "rails_helper"

describe Service do
  it { should validate_presence_of :title }
  it { should validate_presence_of :street }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :category }
  it { should validate_presence_of :subcategory }
  it { should validate_presence_of :site }

  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }
  it { should have_one(:stripe_subscription).dependent(:destroy) }

  it { should have_many(:favorites).dependent(:destroy) }

  describe "#edit_link" do
    it "returns path to edit record" do
      service = build_stubbed(:service)
      edit_path = url_helpers.edit_dashboard_service_path(service)

      result = service.edit_link

      expect(result).to eq edit_path
    end
  end
end
