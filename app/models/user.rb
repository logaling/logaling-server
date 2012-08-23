class User < ActiveRecord::Base
  class << self
    def create_with_omniauth!(auth)
      create! do |user|
        user.provider = auth[:provider]
        user.uid      = auth[:uid]
        user.name     = auth[:info][:name]
      end
    end
  end

  attr_accessible :name, :provider, :uid
end
