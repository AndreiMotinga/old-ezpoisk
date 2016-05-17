class PartnerChargeCalculator
  DAYS_IN_WEEK = 7
  CENTS = 100

  def initialize(weeks, user = nil)
    @weeks = weeks
    @user = user
  end

  def amount_to_pay
    return 100 if @user.try(:admin?)
    @weeks * price * DAYS_IN_WEEK * CENTS
  end

  def price
    return 14 if @weeks == 1
    return 11 if @weeks == 2
    return 9 if @weeks == 4
  end
end
