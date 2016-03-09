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
      User.create(name: name_from_omniauth(auth.info),
                  email: auth.info.email,
                  password: Devise.friendly_token[0, 20],
                  provider: auth.provider,
                  uid: auth.uid)
    end

    def name_from_omniauth(info)
      return info.name if info.name.present? # facebook, vk case
      "#{info.first_name} #{info.last_name}" if info.first_name && info.last_name
    end
  end
end
