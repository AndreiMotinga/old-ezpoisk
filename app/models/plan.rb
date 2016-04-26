class Plan < ActiveRecord::Base
  def extension_period
    case interval
    when "month"
      1.month
    when "year"
      1.year
    end
  end
end
