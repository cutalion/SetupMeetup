class Users::OmniauthCallbacksController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def facebook;  oauth_callback; end
  def twitter;   oauth_callback; end
  def google;    oauth_callback; end
  def developer; oauth_callback; end

  protected

  def oauth_callback
    if current_user
      current_user.connect_with_provider! request.env["omniauth.auth"]
      redirect_to root_url
    else
      @user = User.find_or_create_with_oauth(request.env["omniauth.auth"], current_user)
      provider = request.env['omniauth.auth'].provider

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.capitalize
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.oauth_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end
  end
end
