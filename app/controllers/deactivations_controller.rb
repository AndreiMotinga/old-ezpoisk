class DeactivationsController < ApplicationController
  def create
    return if !current_user
    deactivation = current_user.deactivations.build(deactivation_params)
    @rec = deactivation.deactivatable
    if deactivation.save
      @rec.update_column(:deactivations_count, @rec.deactivations_count + 1)
      @rec.update_column(:active, false) if @rec.deactivations_count > 5
    end
    render "create.js.erb" # spec won't pass
  end

  private

  def deactivation_params
    params.require(:deactivation)
          .permit(:deactivatable_id, :deactivatable_type)
  end
end
