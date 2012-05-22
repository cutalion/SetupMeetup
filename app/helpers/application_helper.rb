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
end
