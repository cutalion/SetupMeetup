module ApplicationHelper
  def gravatar_for(user, options = {})
    gravatar_id = Digest::MD5.hexdigest((user.email || user.id).to_s.downcase)
    image_tag "http://www.gravatar.com/avatar/#{gravatar_id}?s=32&d=identicon&r=PG", { :alt => user.name }.merge(options)
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true, no_images: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def omniauth_providers
    providers = {
      :google   => user_omniauth_authorize_path(:google),
      :facebook => user_omniauth_authorize_path(:facebook),
      :twitter  => user_omniauth_authorize_path(:twitter),
    }
    providers[:developer] = user_omniauth_authorize_path(:developer) unless Rails.env.production?
    providers
  end
end
