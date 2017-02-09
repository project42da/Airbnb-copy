class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates :username, presence: true, length: {maximum: 50}

  def self.from_omniauth(auth)
  	user = User.where(email: auth.info.email).first

  	if user
  		return user
  	else
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  			user.provider = auth.provider
  			user.username = auth.info.email
  			user.uid = auth.uid
  			user.email = auth.info.email
  			user.image = auth.info.image
  			user.password = Devise.friendly_token[0,20]
  			user.skip_confirmation!
  		end
  	end
  end
end
