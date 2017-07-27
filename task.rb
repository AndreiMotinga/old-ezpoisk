Listing.where(kind: "").map &:destroy
Listing.find_each { |l| l.update_column(:kind, I18n.t(l.kind).mb_chars.downcase.to_s) }
Listing.find_each { |l| l.update_column(:category, I18n.t(l.category).mb_chars.downcase.to_s.gsub(",", "").gsub(" ", "-")) }
Listing.find_each { |l| l.update_column(:subcategory, I18n.t(l.subcategory).mb_chars.downcase.to_s.gsub(",", "").gsub(" ", "-")) }
Listing.where(rooms: ["1", "2", ""]).update_all(rooms: "room")
Listing.find_each { |l| next unless l.rooms; l.update_column(:rooms, I18n.t(l.rooms)) }
Listing.find_each { |l| next unless l.duration; l.update_column(:duration, I18n.t(l.duration)) }
