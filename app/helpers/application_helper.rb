module ApplicationHelper
	
	# devise resource for other controller
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  #gravatar
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=indentical&s=150"
  end
  
end
