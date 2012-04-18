class LandingController < ApplicationController
  def index
    
  end

  private

  def events
    Event.future_events
  end
  helper_method :events
end
