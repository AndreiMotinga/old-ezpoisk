require "rails_helper"

describe IncreaseImpressionsJob do
  before { Timecop.freeze(Time.now) }
  after { Timecop.return }
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

  it "touches answer, post and question" do
    answer = create :answer, updated_at: 1.week.ago
    question = create :question, updated_at: 1.week.ago
    post = create :post, updated_at: 1.week.ago

    IncreaseImpressionsJob.perform_async([answer.id], "Answer")
    IncreaseImpressionsJob.perform_async([question.id], "Question")
    IncreaseImpressionsJob.perform_async([post.id], "Post")
    IncreaseImpressionsJob.drain
    [answer, question, post].map(&:reload)

    expect(answer.updated_at).to eq Time.zone.now
    expect(question.updated_at).to eq Time.zone.now
    expect(post.updated_at).to eq Time.zone.now
  end

  it "doesn't touch rp" do
    rp = create :re_private, updated_at: 1.week.ago

    IncreaseImpressionsJob.perform_async([rp.id], "RePrivate")
    IncreaseImpressionsJob.drain
    rp.reload

    expect(rp.updated_at).to eq 1.week.ago
  end
end
