module ApplicationHelper
  def cp(path)
    "active" if request.url.include?(path)
  end

  def category_active?(category, record)
    params[:category] == category || category == record.try(:category)
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def desc(description)
    content_for(:description) { description }
  end

  def template_for(record)
    case record.class.to_s
    when "Service"
      render "services/service", service: record
    when "ReCommercial"
      render "re_commercials/re_commercial", re_commercial: record
    when "RePrivate"
      render "re_privates/re_private", re_private: record
    when "Job"
      render "jobs/job", job: record
    when "Sale"
      render "sales/sale", sale: record
    when "Post"
      render "posts/post", post: record
    end
  end

  def home_controller?
    params[:controller] == "home"
  end

  def profiles_controller?
    params[:controller] == "profiles"
  end
end
