# frozen_string_literal: true

module FormHelper
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
                   placeholder: "Радиус (миль): e.g 20",
                   class: "form-control"
  end

  def sort_select(opts)
    select_tag :sorted,
               options_for_select(opts, params[:sorted]),
               class: "form-control"
  end

  def category_opts
    kind = params[:kind]
    categories = RU_KINDS[kind][:categories].map {|cat| display_option(cat)}
                                            .insert(0, ["Категория", ""])
    options_for_select(categories, params[:category])
  end

  def subcategory_opts
    kind = params[:kind]
    subcategories = RU_KINDS[kind][:subcategories].map { |cat| display_option(cat) }
                                                  .insert(0, ["Подкатегория", ""])
    options_for_select(subcategories, params[:subcategory])
  end

  def service_sub_opts(category, placeholder = nil)
    return [] unless category.present?
    subs = RU_KINDS["услуги"][:subcategories][category]
    return [] unless subs # fix for kind mismatch
    subs = subs.map { |sub| display_option(sub) }
    placeholder ? subs.insert(0, ["Подкатегория", ""]) : subs
  end

  def display_option(phrase)
    [display(phrase), phrase]
  end

  def display(phrase)
    phrase.split("--")
          .map { |w| w.tr("-", " ").capitalize }
          .join(", ")
  end

  def form_state_select(f)
    f.select :state_id,
             State.all.collect { |state| [state.name, state.id] },
             { label: "Штат *", include_blank: true },
             class: "state-select-id mdl-textfield__input"
  end

  def form_city_select(f, record)
    state = record.state
    if state
      f.select :city_id,
               state.cities.collect { |city| [city.name, city.id] },
               { include_blank: true, label: "Город *" },
               class: "city-select mdl-textfield__input"
    else
      f.select :city_id, [], { label: "Город *" }, class: "city-select mdl-textfield__input"
    end
  end
end
