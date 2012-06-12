class Users::AuthorizationsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    current_user.authorizations.where(provider: params[:id].downcase).destroy
    redirect_to user_profile_url
  end
end
