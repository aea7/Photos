class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
     :omniauthable, :omniauth_providers => [:facebook,:twitter]

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid.to_s).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid

        if !auth.info.email.nil?
          user.email = auth.info.email
        else
          o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
          string = (0...15).map { o[rand(o.length)] }.join
          user.email = string + "@gallerio.com"
        end
        user.password = Devise.friendly_token[0,20]
      end
  end
end
