Listing.find_each {|l| l.update_column(:from_name, (0...8).map { (65 + rand(26)).chr }.join ) unless l.from_name.present? }
