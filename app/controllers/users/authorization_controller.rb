class Users::AuthorizationController < ApplicationController
  before_filter :authenticate_user!

  def delete
    current_user.authorizations.where(provider: params[:id].downcase).destroy
    redirect_to user_profile_url
  end
end
