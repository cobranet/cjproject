class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.location = auth.info.location
      user.outh_token = auth.credentials.token
      user.outh_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
