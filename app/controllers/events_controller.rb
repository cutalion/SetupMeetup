class EventsController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!

  protected

  def begin_of_association_chain
    current_user
  end

  def end_of_association_chain
    begin_of_association_chain.owned_events
  end
end
