class PartnerChargeCalculator
  def initialize(weeks, user = nil)
    @weeks = weeks
    @user = user
  end

  def amount_to_pay
    return 100 if @user.try(:admin?)
    # num_of_weeksprice * price * days * 100 cents
    @weeks * price * 7 * 100
  end

  def price
    return 14 if @weeks == 1
    return 11 if @weeks == 2
    return 9 if @weeks == 4
  end
end
