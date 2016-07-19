module ServiceHelper
  def type(service)
    case service.subcategory
    when "Агентства Недвижимости"
      "RealEstateAgent"
    when "Агентства по Трудоустройству"
      "EmploymentAgency"
    else
      "LocalBusiness"
    end
  end
end
