class Ezrealty::RePrivatesController < ApplicationController
  def index
    re_privates = RePrivate.filter(params.slice(:state_id,
                                                :city_id,
                                                :geo_scope,
                                                :fee,
                                                :duration,
                                                :post_type,
                                                :space,
                                                :baths,
                                                :rooms,
                                                :min_price,
                                                :max_price,
                                                :sorted))
    if params[:sorted].blank?
      re_privates = re_privates.order("created_at desc")
    end
    @re_privates = re_privates.page(params[:page])
  end

  def show
    @re_private = get_record RePrivate,
                             params[:id],
                             ezrealty_re_privates_path
  end
end
