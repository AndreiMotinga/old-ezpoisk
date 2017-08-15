# frozen_string_literal: true

class ImpressionsController < ApplicationController
  def show
    ImpressionableJob.perform_in(1.minute,
                                 "Partner",
                                 params[:id],
                                 "visit",
                                 current_user.try(:id),
                                 request.remote_ip,
                                 request.referrer)
    url = params[:final_url]
    url = url.prepend("http://") unless url =~ /http/
    redirect_to url
  end

  def create
    ImpressionableJob.perform_in(1.minute,
                                 "Partner",
                                 params[:id],
                                 "show",
                                 current_user.try(:id),
                                 request.remote_ip,
                                 request.referrer)
  end
end
