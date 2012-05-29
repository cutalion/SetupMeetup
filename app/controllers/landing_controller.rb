class LandingController < ApplicationController
  def index
    
  end

  private

  def future_events
    Event.future_events
  end
  helper_method :future_events

  def past_events
    Event.past_events
  end
  helper_method :past_events
end
