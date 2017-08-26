# frozen_string_literal: true

module OmniLogin
  extend ActiveSupport::Concern

  module ClassMethods
    def from_omniauth(auth)
      # user logged in previously thourgh this provider
      user = User.where(provider: auth.provider, uid: auth.uid).first
      return user if user

      # user logged in previously thourgh other provider
      user = User.find_by_email(auth.info.email)
      return user if user && !auth.info.email.nil?

      # create user if none of the above
      User.create(email: auth.info.email,
                  name: auth.info.name,
                  password: Devise.friendly_token[0, 20],
                  provider: auth.provider,
                  uid: auth.uid,
                  avatar_remote_url: auth.info.image)
    end
  end
end
