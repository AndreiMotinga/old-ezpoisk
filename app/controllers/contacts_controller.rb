# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.contact.update(contact_params)
      redirect_to edit_user_path(current_user, act: "contacts"),
                  notice: I18n.t(:user_updated)
    else
      flash.now[:alert] = I18n.t(:post_not_saved)
      render "users/edit"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:fb, :google, :vk, :site, :street, :skype,
                                    :phone, :state_id, :city_id)
  end
end
