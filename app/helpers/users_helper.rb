module UsersHelper
  # returns gravatar image for user email
  def gravatar_for(user,size=80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    return link_to image_tag(gravatar_url, alt: user.first_name, class: "gravatar", width:size,height:size),user
  end

  
end
