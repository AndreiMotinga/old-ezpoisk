require "rails_helper"

describe FbExporterJob do
  it "posts to facebook" do
    re_private = create(:re_private)
    allow(Fb::Exporter)
      .to receive(:post)
      .with(re_private)

    FbExporterJob.perform_async(re_private.id, "RePrivate")
    FbExporterJob.drain

    expect(Fb::Exporter).to have_received(:post).with(re_private)
  end
end
