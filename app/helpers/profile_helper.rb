module ProfileHelper
  def links_to_related_providers
    providers = current_user.authorizations.map(&:provider)
    if providers.count == 1
      [
        link_to(('<i class="icon-minus-sign icon-white"></i> ' + providers.first).html_safe, 
              '#', 
              class: "btn btn-primary disabled remove-provider", 
              title: "Sorry, you can not destroy your sole authorization"
        )
      ]
    else
      providers.map do |provider|
        caption = ('<i class="icon-minus-sign icon-white"></i> ' + provider).html_safe
        link_to caption, 
                users_authorization_url(provider), 
                class: "btn btn-primary remove-provider", 
                title: "Destroy the #{provider.humanize} authorization",
                method: :delete
      end
    end
  end

  def links_to_allowed_providers
    providers = omniauth_providers.keys.map(&:to_s) - current_user.authorizations.map(&:provider)
    providers.map do |provider|
      caption = ('<i class="icon-plus-sign icon-white"></i> ' + provider.to_s.humanize).html_safe
      link_to caption, 
              user_omniauth_authorize_path(provider), 
              class: "btn btn-primary add-provider", 
              title: "Click for add authorization via #{provider.to_s.humanize}"
    end
  end

  def providers
     links_to_related_providers + links_to_allowed_providers
  end
end