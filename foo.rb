
Listing.where(category: "строительство").update_all(category: "строительство--ремонт")
Listing.where(subcategory: "строительство и ремонт").update_all(subcategory: "строительные-компании")

SUBCATEGORIES.each_pair do |key, val|
  Listing.where(subcategory: key).update_all(subcategory: val)
end
