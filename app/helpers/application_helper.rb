module ApplicationHelper
  def gravatar_for(user, options = {})
    gravatar_id = Digest::MD5.hexdigest((user.email || user.id).to_s.downcase)
    image_tag "http://www.gravatar.com/avatar/#{gravatar_id}?s=32&d=identicon&r=PG", { :alt => user.name }.merge(options)
  end
end
