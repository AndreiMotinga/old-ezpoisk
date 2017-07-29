CSV.open( 'strings.csv', 'w' ) do |writer|
  Listing.where(kind: "работа").find_each do |l|
    writer << [l.text]
  end
end


Listing.where(kind: "услуги").pluck(:text).join.split.each_with_object(Hash.new(0)){|w, result| result[w] += 1 }.sort_by{|k,v| v}
Listing.where(kind: "работа").pluck(:text).join.split.each_with_object(Hash.new(0)){|w, result| result[w] += 1 }.sort_by{|k,v| v}



CSV.open( 'strings', 'w' ) do |writer|
  Listing.where(kind: "работа").pluck(:text).each do |t|
    writer <<  [t]
  end
end

Listing.where(kind: "работа", subcategory: "автосервисы").update_all(subcategory: "ремонт-автомобилей")
Listing.where(kind: "работа", subcategory: "искусство").update_all(subcategory: "артисты-развлечения")
Listing.where(kind: "работа", subcategory: "няни-сиделки").update_all(subcategory: "няни-сиделки-домработницы")
Listing.where(kind: "работа", subcategory: "образование").update_all(subcategory: "образование-учителя-воспитатели")
Listing.where(kind: "работа", subcategory: "офис").update_all(subcategory: "образование-учителя-воспитатели")
Listing.where(kind: "работа", subcategory: "реклама-и-pr").update_all(subcategory: "реклама-маркетинг")
Listing.where(kind: "работа", subcategory: "рестораны-развлечения").update_all(subcategory: "бары-кафе-рестораны")
Visting.where(kind: "работа", subcategory: "спорт-фитнес").update_all(subcategory: "спорт-здоровье")
Listing.where(kind: "работа", subcategory: "продажи").update_all(subcategory: "продавцы-кассиры-администраторы")
Listing.where(subcategory: "другое").update_all(subcategory: "другое-разное")
