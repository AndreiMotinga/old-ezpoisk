KINDS.keys.each do |kind|
  KINDS[I18n.t(kind).mb_chars.downcase.to_s] = KINDS[kind]
  KINDS.delete(kind)
end

["работа", "продажи", "недвижимость"].each do |kind|
  ["categories", "subcategories"].each do |type|
    KINDS[kind][type] = KINDS[kind][type].map {|k| I18n.t(k).mb_chars.downcase.gsub(" ", "-").to_s }
  end
end


KINDS["недвижимость"]["rooms"] = KINDS["недвижимость"]["rooms"].map {|k| I18n.t(k).mb_chars.downcase.gsub(" ", "-").to_s }
KINDS["недвижимость"]["duration"] = KINDS["недвижимость"]["duration"].map {|k| I18n.t(k).mb_chars.downcase.gsub(" ", "-").to_s }


KINDS["услуги"]["categories"] = KINDS["услуги"]["categories"].map {|k| I18n.t(k).mb_chars.downcase.gsub(" ", "-").to_s }

KINDS["услуги"]["subcategories"].keys.each do |cat|
  KINDS["услуги"]["subcategories"][I18n.t(cat).mb_chars.downcase.to_s] = KINDS["услуги"]["subcategories"][cat]
  KINDS["услуги"]["subcategories"].delete(cat)
end

KINDS["услуги"]["subcategories"].keys.each do |cat|
  KINDS["услуги"]["subcategories"][cat] = KINDS["услуги"]["subcategories"][cat].map  {|k| I18n.t(k).mb_chars.downcase.gsub(" ", "-").to_s }
end
