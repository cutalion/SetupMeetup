class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  protected

  def not_found
    render file: File.join(Rails.root, "public", "404"), layout: false, status: :not_found
  end
end
