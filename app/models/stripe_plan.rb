class StripePlan < ActiveRecord::Base
  def savings
    (total.to_f - amount)/100
  end
end
