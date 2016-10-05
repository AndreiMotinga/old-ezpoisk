require "rails_helper"

describe Job do
  it { should validate_presence_of :city_id }
  it { should validate_presence_of :state_id }
  it { should validate_presence_of :text }
  it { should validate_presence_of :title }

  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:state) }

  it { should have_many(:favorites).dependent(:destroy) }
  it { should have_many(:subscriptions).dependent(:destroy) }

  describe "address" do
    context "full string" do
      it "returns full address" do
        job = build :job,
                     state_id: 32,
                     city_id: 18_031,
                     zip: 11_229,
                     street: "1970 East 18th"
        address = "1970 East 18th Astoria New York 11229"
        expect(job.address).to eq address
      end

      it "returns address without street" do
        job = build :job,
                     state_id: 32,
                     city_id: 18_031,
                     zip: 11_229,
                     street: ""
        address = "Astoria New York 11229"
        expect(job.address).to eq address
      end

      it "returns address without street and zip" do
        job = build :job,
                     state_id: 32,
                     city_id: 18_031,
                     zip: nil,
                     street: ""
        address = "Astoria New York"
        expect(job.address).to eq address
      end
    end
  end

  describe "#edit_link" do
    it "returns path to edit record" do
      job = build_stubbed(:job)
      edit_path = url_helpers.edit_dashboard_job_path(job)

      result = job.edit_link

      expect(result).to eq edit_path
    end
  end
end
