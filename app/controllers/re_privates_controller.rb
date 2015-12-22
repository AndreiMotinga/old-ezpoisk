class RePrivatesController < ApplicationController
  before_action :set_re_private, only: [:show, :edit, :update, :destroy]

  # GET /re_privates
  def index
    @re_privates = RePrivate.all
  end

  # GET /re_privates/1
  def show
  end

  # GET /re_privates/new
  def new
    @re_private = RePrivate.new
  end

  # GET /re_privates/1/edit
  def edit
  end

  # POST /re_privates
  def create
    @re_private = RePrivate.new(re_private_params)

    if @re_private.save
      redirect_to @re_private, notice: 'Re private was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /re_privates/1
  def update
    if @re_private.update(re_private_params)
      redirect_to @re_private, notice: 'Re private was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /re_privates/1
  def destroy
    @re_private.destroy
    redirect_to re_privates_url, notice: 'Re private was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_re_private
      @re_private = RePrivate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def re_private_params
      params[:re_private]
    end
end
