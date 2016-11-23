# todo remove
task create_listings: :environment do
  Sale.where(category: "sale").update_all(category: "other")

  Job.find_each do |p|
    listing = Listing.create(
      kind: "jobs",
      title: p.title,
      text: p.text,
      phone: p.phone,
      email: p.email,
      category: p.post_type,
      subcategory: p.category,
      active: p.active,
      state_id: p.state_id,
      city_id: p.city_id,
      user_id: p.user_id,
      lat: p.lat,
      lng: p.lng,
      zip: p.zip,
      created_at: p.created_at,
      updated_at: p.updated_at,
      street: p.street,
      impressions_count: p.impressions_count,
      visits: p.visits,
      token: p.token,
      priority: p.priority,
      vk: p.vk,
      fb: p.fb,
      featured: p.featured
    )
    Favorite.where(favorable_id: p.id, favorable_type: p.class.name)
      .update_all(favorable_id: listing.id, favorable_type: "Listing")
  end

  Sale.find_each do |p|
    listing = Listing.create(
      kind: "sales",
      category: p.post_type,
      subcategory: p.category,
      title: p.title,
      text: p.text,
      phone: p.phone,
      email: p.email,
      active: p.active,
      state_id: p.state_id,
      city_id: p.city_id,
      user_id: p.user_id,
      lat: p.lat,
      lng: p.lng,
      zip: p.zip,
      created_at: p.created_at,
      updated_at: p.updated_at,
      street: p.street,
      impressions_count: p.impressions_count,
      visits: p.visits,
      token: p.token,
      priority: p.priority,
      vk: p.vk,
      fb: p.fb,
      featured: p.featured,
      price: p.price
    )

    p.pictures.each do |pic|
      pic.imageable_type = "Listing"
      pic.imageable_id = listing.id
      pic.save
    end
    Favorite.where(favorable_id: p.id, favorable_type: p.class.name)
      .update_all(favorable_id: listing.id, favorable_type: "Listing")
  end

  RePrivate.find_each do |p|
    listing = Listing.create(
      kind: "real-estate",
      category: p.post_type,
      subcategory: p.category,
      title: p.title,
      text: p.text,
      phone: p.phone,
      email: p.email,
      active: p.active,
      state_id: p.state_id,
      city_id: p.city_id,
      user_id: p.user_id,
      lat: p.lat,
      lng: p.lng,
      zip: p.zip,
      created_at: p.created_at,
      updated_at: p.updated_at,
      street: p.street,
      impressions_count: p.impressions_count,
      visits: p.visits,
      token: p.token,
      priority: p.priority,
      vk: p.vk,
      fb: p.fb,
      featured: p.featured,
      price: p.price,
      baths: p.baths,
      space: p.space,
      rooms: p.rooms,
      fee: p.fee,
      duration: p.duration
    )

    p.pictures.each do |pic|
      pic.imageable_type = "Listing"
      pic.imageable_id = listing.id
      pic.save
    end
    Favorite.where(favorable_id: p.id, favorable_type: p.class.name)
      .update_all(favorable_id: listing.id, favorable_type: "Listing")
  end

  Service.find_each do |p|
    listing = Listing.create(
      kind: "services",
      category: p.category,
      subcategory: p.subcategory,
      title: p.title,
      text: p.text,
      phone: p.phone,
      email: p.email,
      active: p.active,
      state_id: p.state_id,
      city_id: p.city_id,
      user_id: p.user_id,
      lat: p.lat,
      lng: p.lng,
      zip: p.zip,
      created_at: p.created_at,
      updated_at: p.updated_at,
      street: p.street,
      impressions_count: p.impressions_count,
      visits: p.visits,
      token: p.token,
      priority: p.priority,
      vk: p.vk,
      fb: p.fb,
      featured: p.featured,
      site: p.site,
      gl: p.google,
      tw: p.twitter,
      ok: p.ok
    )

    if p.logo?
      pic = Picture.create(imageable_type: "Listing",
                           imageable_id: listing.id,
                           user_id: listing.user_id,
                           logo: true)
      begin
        pic.image = p.logo.url(:original)
        pic.save
      rescue
        begin
          pic.image = p.logo.url.gsub("jpg", "jpeg")
          pic.save
        rescue
          pic.destroy
        end
      end
    end

    p.pictures.each do |pic|
      pic.imageable_type = "Listing"
      pic.imageable_id = listing.id
      pic.save
    end

    Favorite.where(favorable_id: p.id, favorable_type: "Service").update_all(favorable_id: listing.id, favorable_type: "Listing")
  end
end
