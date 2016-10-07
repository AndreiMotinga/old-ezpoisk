require "rails_helper"

describe FbExporterJob do
  it "posts to facebook" do
    re_private = create(:re_private)
    stub_facebook_notifier(re_private)

    FbExporterJob.perform_async(re_private.id, "RePrivate")
    FbExporterJob.drain

    expect(FbExporter).to have_received(:post).with(re_private)
  end

  def stub_facebook_notifier(record)
    allow(FbExporter)
      .to receive(:post)
      .with(record)
  end
end
