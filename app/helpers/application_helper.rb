module ApplicationHelper
  def cp(path)
    "active" if request.url.include?(path)
  end

  def category_active?(category, record = nil)
    if params[:category] == category || category == record.try(:category)
      "active"
    end
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def desc(description)
    content_for(:description) { description }
  end

  def template_for(record)
    case record.class.to_s
    when "ReAgency"
      render "re_agencies/re_agency", re_agency: record
    when "ReFinance"
      render "re_finances/re_finance", re_finance: record
    when "Service"
      render "services/service", service: record
    when "JobAgency"
      render "job_agencies/job_agency", job_agency: record
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

  def stripped_200(desc)
    strip_tags(desc).truncate(200)
  end
end
