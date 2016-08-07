require "rails_helper"

describe IncreaseImpressionsJob do
  it "increases impressions when user visits index page" do
    increased = create_list(:re_private, 10)
    untouched = create_list(:re_private, 5)

    IncreaseImpressionsJob.perform_async(increased.pluck(:id), "RePrivate")
    IncreaseImpressionsJob.drain

    ones = increased.map(&:reload).pluck(:impressions_count)
    expect(ones).to eq Array.new(10).map{|el| el = 1 } #[1,1,1,...1]

    zeroes = untouched.map(&:reload).pluck(:impressions_count)
    expect(zeroes).to eq Array.new(5).map{|el| el = 0 }
  end
end
