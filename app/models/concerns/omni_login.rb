module OmniLogin
  extend ActiveSupport::Concern

  module ClassMethods
    def from_omniauth(auth)
      # user logged in previously thourgh this provider
      user = User.where(provider: auth.provider, uid: auth.uid).first
      return user if user

      # user logged in previously thourgh other provider
      user = User.find_by_email(auth.info.email)
      return user if user

      # create user if none of the above
      u = User.create(email: auth.info.email,
                      name: auth.info.name,
                      password: Devise.friendly_token[0, 20],
                      provider: auth.provider,
                      uid: auth.uid)
      if auth.provider == "vkontakte"
        u.avatar_remote_url = auth.info.image
      else
        u.avatar_remote_url = auth.info.image.gsub("http://", "https://")
      end
      u.save
      u
    end
  end
end
