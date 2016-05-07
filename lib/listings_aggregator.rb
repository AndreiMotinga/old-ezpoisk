class ListingsAggregator
  def initialize(user, keyword = nil, model = nil)
    @user = user
    @keyword = keyword
    @model = model
  end

  def listings
    if @model.present? && @keyword.present?
      @posts = find_by_model_and_key(@model.constantize, @keyword)
    elsif @model.present?
      @posts = find_by_model(@model.constantize)
    elsif @keyword.present?
      @posts = re_p + re_c + jobs + services + sales
    else
      @posts = all
    end
    @posts.sort_by(&:updated_at).reverse
  end

  def find_by_model_and_key(model, key)
    if model.method_defined? :street
      model.where(user_id: @user.id).filter(street: key)
    else
      model.where(user_id: @user.id).filter(keyword: key)
    end
  end

  def all
    MODELS.map { |model| model[1].constantize.where(user_id: @user.id) }
          .flatten
  end

  def find_by_model(model)
    model.where(user: @user)
  end

  def re_p
    @user.re_privates.filter(street: @keyword)
  end

  def re_c
    @user.re_commercials.filter(street: @keyword)
  end

  def jobs
    @user.jobs.filter(keyword: @keyword)
  end

  def services
    @user.services.filter(keyword: @keyword)
  end

  def sales
    @user.sales.filter(keyword: @keyword)
  end
end
