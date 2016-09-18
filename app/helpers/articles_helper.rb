module ArticlesHelper
  def total_price(records)
    records.map(&:size).sum / 2000.0
  end
end
