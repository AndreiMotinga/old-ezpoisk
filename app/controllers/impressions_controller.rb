# frozen_string_literal: true

class ImpressionsController < ApplicationController
  def show
    unless request.referrer == edit_partner_url(params[:id])
      ImpressionableJob.perform_async("Partner",
                                      params[:id],
                                      "visit",
                                      current_user.try(:id),
                                      request.remote_ip,
                                      request.referrer)
    end
    url = params[:final_url]
    url = url.prepend("http://") unless url =~ /http/
    redirect_to url
  end

  def create
    params[:ids].each do |id|
      ImpressionableJob.perform_async("Partner",
                                      id,
                                      "show",
                                      current_user.try(:id),
                                      request.remote_ip,
                                      request.referrer)
    end
    head 201
  end
end
