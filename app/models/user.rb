class User
  include Mongoid::Document
  
  field :uid, type: String
  field :username, type: String
  field :token, type: String
  field :secret, type: String

  def self.omniauth_lookup(auth)
  	where(auth.slice("uid")).first || omniauth_create(auth)
  end

  def self.omniauth_create(auth)
  	create! do |user|
  	  user.uid = auth["uid"]
  	  user.username = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
  	end
  end
end