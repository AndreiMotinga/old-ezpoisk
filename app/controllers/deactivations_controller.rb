class DeactivationsController < ApplicationController
  def create
    return if !current_user
    deactivation = current_user.deactivations.build(deactivation_params)
    @rec = deactivation.deactivatable
    deactivation.save
    @rec.update_column(:active, false) if @rec.deactivations.count > 5
    render "create.js.erb"
  end

  private

  def deactivation_params
    params.require(:deactivation)
          .permit(:deactivatable_id, :deactivatable_type)
  end
end
