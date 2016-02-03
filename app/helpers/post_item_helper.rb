module PostItemHelper
  def link_from_controller(record)
    case record.class.to_s
    when "ReAgency"
      path_for_re_agency(record)
    when "JobAgency"
      path_for_job_agency(record)
    when "Job"
      path_for_job(record)
    when "RePrivate"
      path_for_re_private(record)
    when "ReCommercial"
      path_for_re_commercial(record)
    when "Sale"
      path_for_sale(record)
    when "Service"
      path_for_service(record)
    end
  end

  def path_for_service(record)
    if params[:controller] == "services"
      service_path(record)
    else
      edit_dashboard_service_path(record)
    end
  end

  def path_for_sale(record)
    if params[:controller] == "sales"
      sale_path(record)
    else
      edit_dashboard_sale_path(record)
    end
  end

  def path_for_re_commercial(record)
    if params[:controller] == "real_estate/re_commercials"
      real_estate_re_commercial_path(record)
    else
      edit_dashboard_re_commercial_path(record)
    end
  end

  def path_for_re_private(record)
    if params[:controller] == "real_estate/re_privates"
      real_estate_re_private_path(record)
    else
      edit_dashboard_re_private_path(record)
    end
  end

  def path_for_re_agency(record)
    if params[:controller] == "real_estate/re_agencies"
      real_estate_re_agency_path(record)
    else
      edit_dashboard_re_agency_path(record)
    end
  end

  def path_for_job_agency(record)
    if params[:controller] == "jobs/job_agencies"
      jobs_job_agency_path(record)
    else
      edit_dashboard_job_agency_path(record)
    end
  end

  def path_for_job(record)
    if params[:controller] == "jobs/jobs"
      jobs_job_path(record)
    else
      edit_dashboard_job_path(record)
    end
  end
end
