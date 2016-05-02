module PartnersHelper
  def page_grouped_options
    pages = HashWithIndifferentAccess.new(
      "Домашняя": ["Домашняя"],
      "- Раздел Недвижимость": ["Частная", "Коммерческая", "Агентства Недвижимости", "Финансирование"],
      "- Раздел Работа": ["Работа", "Агентства по Трудоустройству"],
      "- Раздел Вопросы": ["Вопросы"],
      "- Раздел Новости": ["Новости"],
    )

    pages["- Раздел Продажи"] = SALE_CATEGORIES
    pages["- Раздел Услуги"] = []

    SERVICE_CATEGORIES.each do |category, subcategory|
      pages[category] = subcategory
    end

    pages
  end
end
