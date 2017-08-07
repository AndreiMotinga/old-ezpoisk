class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  def facebook
    register_user("Facebook")
  end

  def google_oauth2
    register_user("Google")
  end

  def vkontakte
    register_user("Vkontakte")
  end

  private

  def register_user(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      remember_me(@user)
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end
end
