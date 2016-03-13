module PostItemHelper
  def link_from_controller(record)
    case record.class.to_s
    when "ReAgency"
      path_for_re_agency(record)
    when "ReFinance"
      path_for_re_finance(record)
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
    if params[:controller] == "services" ||
       params[:controller] == "dashboard/favorites"
      service_path(record)
    else
      edit_dashboard_service_path(record)
    end
  end

  def path_for_sale(record)
    if params[:controller] == "sales" ||
       params[:controller] == "dashboard/favorites"
      sale_path(record)
    else
      edit_dashboard_sale_path(record)
    end
  end

  def path_for_re_commercial(record)
    if params[:controller] == "ezrealty/re_commercials" ||
       params[:controller] == "dashboard/favorites"
      ezrealty_re_commercial_path(record)
    else
      edit_dashboard_re_commercial_path(record)
    end
  end

  def path_for_re_private(record)
    if params[:controller] == "ezrealty/re_privates" ||
       params[:controller] == "dashboard/favorites"
      ezrealty_re_private_path(record)
    else
      edit_dashboard_re_private_path(record)
    end
  end

  def path_for_re_agency(record)
    if params[:controller] == "ezrealty/re_agencies" ||
       params[:controller] == "dashboard/favorites"
      ezrealty_re_agency_path(record)
    else
      edit_dashboard_re_agency_path(record)
    end
  end

  def path_for_re_finance(record)
    if params[:controller] == "ezrealty/re_finances" ||
       params[:controller] == "dashboard/favorites"
      ezrealty_re_finance_path(record)
    else
      edit_dashboard_re_finance_path(record)
    end
  end

  def path_for_job_agency(record)
    if params[:controller] == "ezjob/job_agencies" ||
       params[:controller] == "dashboard/favorites"
      ezjob_job_agency_path(record)
    else
      edit_dashboard_job_agency_path(record)
    end
  end

  def path_for_job(record)
    if params[:controller] == "ezjob/jobs" ||
       params[:controller] == "dashboard/favorites"
      ezjob_job_path(record)
    else
      edit_dashboard_job_path(record)
    end
  end
end
