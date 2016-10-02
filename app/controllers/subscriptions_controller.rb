class SubscriptionsController < ApplicationController
  before_action :set_record

  def create
    @subscription = current_user.subscriptions.create(
      subscribable_id: params[:id],
      subscribable_type: params[:type],
    )
  end

  def destroy
    Subscription.find_by(
      user: current_user,
      subscribable_id: @record.id,
      subscribable_type: @record.class.to_s
    ).destroy
  end

  private

  def set_record
    model = [RePrivate, Job, Sale, Service, Question].find do |m|
      m.name == params[:type]
    end
    @record = model.find(params[:id])
  end
end
