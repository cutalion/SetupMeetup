class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found

  protected

  def not_found
    render file: File.join(Rails.root, "public", "404"), layout: false, status: :not_found
  end

  def current_user=(user)
    session['uid'] = user.try(:id)
  end

  def current_user
    @current_user ||= session['uid'] ? User.find(session['uid']) : nil
  end
  helper_method :current_user

  def authenticate_user!
    unless current_user
      redirect_to :root, alert: 'You need an account to access this feature.'
    end
  end

  def user_signed_in?
    !!current_user
  end
  helper_method :user_signed_in?

end
