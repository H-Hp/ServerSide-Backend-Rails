class OpenidUser < ApplicationRecord
    def self.find_or_create_by_auth(auth)
      user = OpenidUser.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        #user.avatar_url = auth.info.image
      end
      
      user.update(
        name: auth.info.name,
        email: auth.info.email,
        #avatar_url: auth.info.image
      )
      
      user
    end
  end
  