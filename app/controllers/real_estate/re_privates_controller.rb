class RealEstate::RePrivatesController < ApplicationController
  def index
    @re_privates = RePrivate.all.page params[:page]
  end

  def show
    @re_private = RePrivate.find(params[:id])
  end
end
