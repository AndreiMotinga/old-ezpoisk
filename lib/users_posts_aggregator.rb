class UsersPostsAggregator
  def initialize(user, keyword = nil, model = nil)
    @user = user
    @keyword = keyword
    @model = model
  end

  def users_posts
    if @model.present? && @keyword.present?
      @posts = find_by_model_and_key(@model.constantize, @keyword)
    elsif @model.present?
      @posts = find_by_model(@model.constantize)
    else
      @posts = re_a + re_p + re_c + job_a + jobs + services + sales
    end
    @posts.sort_by(&:updated_at).reverse
  end

  def find_by_model_and_key(model, key)
    if model == RePrivate || model == ReCommercial
      model.where(user: @user).filter(street: key)
    else
      model.where(user: @user).filter(keyword: key)
    end
  end

  def find_by_model(model)
    model.where(user: @user)
  end

  def re_a
    if @keyword.present?
      posts = @user.re_agencies.filter(keyword: @keyword)
    else
      posts = @user.re_agencies
    end
    posts
  end

  def re_p
    if @keyword.present?
      posts = @user.re_privates.filter(street: @keyword)
    else
      posts = @user.re_privates
    end
    posts
  end

  def re_c
    if @keyword.present?
      posts = @user.re_commercials.filter(street: @keyword)
    else
      posts = @user.re_commercials
    end
    posts
  end

  def job_a
    if @keyword.present?
      posts = @user.job_agencies.filter(keyword: @keyword)
    else
      posts = @user.job_agencies
    end
    posts
  end

  def jobs
    if @keyword.present?
      posts = @user.jobs.filter(keyword: @keyword)
    else
      posts = @user.jobs
    end
    posts
  end

  def services
    if @keyword.present?
      posts = @user.services.filter(keyword: @keyword)
    else
      posts = @user.services
    end
    posts
  end

  def sales
    if @keyword.present?
      posts = @user.sales.filter(keyword: @keyword)
    else
      posts = @user.sales
    end
    posts
  end
end
