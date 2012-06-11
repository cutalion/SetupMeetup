class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  protected

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def not_found
    render file: File.join(Rails.root, "public", "404"), layout: false, status: :not_found
  end
end
