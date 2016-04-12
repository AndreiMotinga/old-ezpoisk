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
      render "dashboard/shared/company", record: record
    when "ReFinance"
      render "dashboard/shared/company", record: record
    when "Service"
      render "dashboard/shared/company", record: record
    when "JobAgency"
      render "dashboard/shared/company", record: record
    when "ReCommercial"
      render "dashboard/re_commercials/re_commercial", record: record
    when "RePrivate"
      render "dashboard/re_privates/re_private", record: record
    when "Job"
      render "dashboard/jobs/job", record: record
    when "Sale"
      render "dashboard/sales/sale", record: record
    end
  end

  def home_controller?
    "hidden" if params[:controller] == "home"
  end
end
