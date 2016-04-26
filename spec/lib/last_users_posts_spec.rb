require "rails_helper"

describe LastUsersPosts do
  it "return last users posts" do
    re_private = create :re_private, :active, street: "old str"
    service = create :service, title: "old service"
    job = create :job, :active, title: "old job"
    sale = create :sale, :active, title: "old sale"

    new_re_private = create :re_private, :active, street: "new str"
    new_service = create :service, title: "new service"
    new_job = create :job, :active, title: "new job"
    new_sale = create :sale, :active, title: "new sale"

    posts = LastUsersPosts.new.last_posts(10)
    expect(posts.map(&:title)).to eq(jobs)
  end
end

def jobs
  ["new sale", "new job", "new service", "new str", "old sale", "old job",
    "old service", "old str"]
end
