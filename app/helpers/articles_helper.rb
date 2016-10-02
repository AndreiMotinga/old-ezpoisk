module ArticlesHelper
  def total_price(records)
    records.map { |rec| payable_size(rec.text) }.sum / 2000.0
  end

  def payable_amount(text)
    number_to_currency(payable_size(text) / 2000.0, locale: :en)
  end

  def payable_size(text)
    ActionView::Base.full_sanitizer.sanitize(text).gsub("\s+", " ").size
  end
end
