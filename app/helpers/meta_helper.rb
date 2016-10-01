module MetaHelper
  def desc(description)
    content_for(:description) { description }
  end

  def og_url(og_url)
    content_for(:og_url) { og_url }
  end

  def og_type(og_type)
    content_for(:og_type) { og_type }
  end

  def og_image(og_image)
    content_for(:og_image) { og_image }
  end

  def tr(arg)
    return "" unless arg.present?
    t(arg)
  end

  def state_title(slug)
    State.find_by_slug(slug).name
  end

  def city_title(slug)
    City.find_by_slug(slug).name
  end

  def title(default, prefix = "")
    text = prefix
    text += param_exist? ? params_title_string : default
    content_for(:title) { text }
  end

  def params_title_string
    string = ""
    string =  "#{tr params[:post_type]} " if params[:post_type].present?
    string += "#{tr params[:category]} " if params[:category].present?
    string += "#{tr params[:subcategory]} | " if params[:subcategory].present?
    string += "#{city_title(params[:city])} " if params[:city].present?
    string += "#{state_title(params[:state])} " if params[:state].present?
    string += "США - ezpoisk"
  end

  def param_exist?
    return true if params[:category]
    return true if params[:subcategory]
    return true if params[:state_id]
    return true if params[:city_id]
    return true if params[:post_type]
  end

  def question_title
    case params[:action]
    when 'index'
      title("Есть вопрос? задавайте! Комьюнити наших в америке - ezpoisk")
    when 'tag'
      titledesc("Наши в США. Вопросы на тему #{params[:tag]} - ezpoisk")
    when 'unanswered'
      titledesc("Неотвеченные вопросы. - ezpoisk")
    when 'unanswered_tag'
      titledesc("Неотвеченные вопросы на тему #{params[:tag]} -  ezpoisk")
    end
  end
  def question_desc
    case params[:action]
    when 'index'
      desc("Получите информацию на интересующую вас тему из первых рук. Советы адвокатов, риэлторов, врачей")
    when 'tag'
      desc("#{params[:tag]} - все, что нужно знать иммигранту в америке. - ezpoisk")
    when 'unanswered'
      desc("Помощь иммигрантам в США, добавьте свой ответ, помогите получить информацию. We're in this together. - ezpoisk")
    when 'unanswered_tag'
      desc("#{params[:tag]} - Помощь иммигрантам в США, добавьте свой ответ, помогите получить информацию. - ezpoisk")
    end
  end

  def post_title
    case params[:action]
    when 'index'
      title("Новости, информация об иммиграции в США - ezpoisk")
    when 'tag'
      desc("Наши в США. Статьи на тему #{params[:tag]} - ezpoisk")
    end
  end

  def post_desc
    case params[:action]
    when 'index'
      desc("Новости русской иммиграции в США. Информцаия о наших от Бостона до Сан Франциско")
    when 'tag'
      desc("Наши в США. Статьи на тему #{params[:tag]} - ezpoisk")
    end
  end
end
