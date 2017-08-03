User.where("name = ? OR name = ?", "", nil).update_all(name: "Unknown")
