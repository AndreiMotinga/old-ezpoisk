module FormHelper
  def state_select_with_param
    options_for_select(STATES, state_id)
  end

  def state_id
    # params[:state_id] || current_user.try(:state_id) || 32
    params[:state_id]
  end

  def city_select_with_param
    options_from_collection_for_select(state_cities, :id, :name, city_id)
  end

  def city_id
    # params[:city_id] || current_user.try(:city_id) || 18_031
    params[:city_id]
  end

  def state_cities
    return [] unless params[:state_id].present?
    City.where(state_id: state_id)
  end

  def sort_select
    select_tag :sorted,
               options_for_select({ "Цена вверх" => "price asc",
                                    "Цена вниз" => "price desc",
                                    "Площадь вверх" => "space asc",
                                    "Площадь вниз" => "space desc",
                                    "По дате" => "updated_at desc" },
                                  params[:sorted]),
               include_blank: true,
               class: "form-control"
  end

  def service_categories_options
    options_for_select(SERVICE_CATEGORIES.keys, params[:category])
  end

  def service_subcategories_options
    category = params[:category]
    return unless category.present?
    options_for_select(SERVICE_CATEGORIES[category], params[:subcategory])
  end

  def origin
    params[:geo_scope][:origin] unless params[:geo_scope].blank?
  end

  def within
    params[:geo_scope][:within] unless params[:geo_scope].blank?
  end

  def origin_text_field_param
    text_field_tag "geo_scope[origin]",
                   origin,
                   placeholder: "1970 East 18 Brooklyn New York или 11229",
                   class: "form-control"
  end

  def within_text_field_param
    select_tag "geo_scope[within]",
               options_for_select(DISTANCE, within),
               include_blank: true,
               class: "form-control"
  end

  def form_state_select(f)
    f.select :state_id,
             State.all.collect {|s| [ s.name, s.id ] },
             { include_blank: true , label: '* Штат'},
             { class: "state-select" }
  end

  def form_city_select(f, record)
    if record.state
      f.select :city_id,
               record.state.cities.collect { |city| [city.name, city.id] },
               { label: "* Город" },
               class: "city-select"
    else
      f.select :city_id, [], { label: "* Город" }, class: "city-select"
    end
  end

  def news_options(post = nil)
    return NEWS_CATEGORIES.keys unless post.category
    options_for_select(NEWS_CATEGORIES.keys, @post.category.split(" "))
  end
end
