module FormHelper
  def state_id
    params[:state_id] || current_user.try(:state_id) || 32
  end

  def city_id
    params[:city_id] || current_user.try(:city_id) || 18_031
  end

  def state_cities
    City.where(state_id: state_id)
  end

  def sort_select
    sort_opts = { "Подешевле" => "price asc",
                  "Подороже"  => "price desc",
                  "Поменьше"  => "space asc",
                  "Побольше"  => "space desc",
                  "Поновее"   => "updated_at desc" }
    select_tag(:sorted,
               options_for_select(sort_opts, params[:sorted]),
               class: "form-control")
  end

  def service_subcategories_options
    category = params[:category]
    return unless category.present?
    options_for_select(SERVICE_SUBCATEGORIES[category], params[:subcategory])
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
                   placeholder: "2424 Coney Island ave Brooklyn New York or 11229",
                   class: "form-control"
  end

  def within_text_field_param
    text_field_tag "geo_scope[within]",
                   within,
                   placeholder: "e.g 20",
                   class: "form-control"
  end

  def form_state_select(f)
    f.select :state_id,
             State.all.collect { |state| [state.name, state.id] },
             { label: "* Штат" },
             class: "state-select my-dropdown"
  end

  def form_city_select(f, record)
    state = record.state
    if state
      f.select :city_id,
               state.cities.collect { |city| [city.name, city.id] },
               { label: "* Город" },
               class: "city-select my-dropdown-multiple"
    else
      f.select :city_id, [], { label: "* Город" }, class: "city-select my-dropdown-multiple"
    end
  end

  def ru(opts)
    opts.map{|k| [t(k), k] }
  end
end
