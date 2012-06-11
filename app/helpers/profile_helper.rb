module ProfileHelper
  def links_to_related_providers
    providers = current_user.authorizations.map(&:provider)
    if providers.count == 1
      [
        link_to(('<i class="icon-minus-sign icon-white"></i> ' + providers.first).html_safe, 
              '#', 
              class: "btn btn-primary disabled", 
              title: "Sorry, you can not destroy your sole authorization"
        )
      ]
    else
      providers.map do |provider|
        caption = ('<i class="icon-minus-sign icon-white"></i> ' + provider).html_safe
        link_to caption, 
                users_authorization_url(provider), 
                class: "btn btn-primary", 
                title: "Destroy the #{provider.humanize} authorization",
                method: :delete
      end
    end
  end

  def allowed_providers
    ['facebook', 'twitter', 'google'] - current_user.authorizations.map(&:provider)
  end

  def links_to_allowed_providers
    allowed_providers.map do |provider|
      caption = ('<i class="icon-plus-sign icon-white"></i> ' + provider).html_safe
      link_to caption, 
              user_omniauth_authorize_path(provider), 
              class: "btn btn-primary", 
              title: "Click for add authorization via #{provider.humanize}"
    end
  end
end