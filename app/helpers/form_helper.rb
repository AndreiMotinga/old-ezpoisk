module FormHelper
  def state_cities
    return [] unless state
    City.where(state_slug: state).or(City.where(slug: City::ALL))
  end

  def state
    return params[:state] if params[:state]
    return current_user.try(:state_slug) if current_user.try(:state_slug)
  end

  def city
    return params[:city] if params[:city]
    return current_user.try(:city_slug) if current_user.try(:city_slug)
  end

  def rp_sort_opts
    { "Сортировать": "",
      "Подешевле": "price asc",
      "Подороже": "case when price is null then -1 else price end desc",
      "Поменьше": "space asc",
      "Побольше": "space desc",
      "Поновее": "created_at desc" }
  end

  def sale_sort_opts
    { "Сортировать": "",
      "Подешевле": "price asc",
      "Подороже": "case when price is null then -1 else price end desc",
      "Поновее": "created_at desc" }
  end

  def sort_select(opts)
    select_tag(:sorted,
               options_for_select(opts, params[:sorted]),
               class: "form-control")
  end

  def service_subcategories_options
    category = params[:category]
    return unless category.present?
    opts = [["Категория", ""]] + ru(Service::SUBCATEGORIES[category])
    options_for_select(opts, params[:subcategory])
  end

  def origin
    params[:geo_scope][:origin] if params[:geo_scope].present?
  end

  def within
    params[:geo_scope][:within] if params[:geo_scope].present?
  end

  def origin_text_field_param
    text_field_tag "geo_scope[origin]",
                   origin,
                   placeholder: "2424 Coney Island ave, Brooklyn New York or 11229",
                   class: "form-control"
  end

  def within_text_field_param
    text_field_tag "geo_scope[within]",
                   within,
                   placeholder: "20",
                   class: "form-control"
  end

  def form_state_select(f)
    f.select :state_id,
             State.all.collect { |state| [state.name, state.id] },
             { label: "* Штат", include_blank: true },
             class: "state-select-id my-dropdown"
  end

  def form_city_select(f, record)
    state = record.state
    if state
      f.select :city_id,
               state.cities.collect { |city| [city.name, city.id] },
               { label: "* Город" },
               class: "city-select my-dropdown"
    else
      f.select :city_id, [], { label: "* Город" }, class: "city-select my-dropdown"
    end
  end

  def ru(opts)
    return "" unless opts
    opts.map{ |k| [t(k), k] }
  end
end
