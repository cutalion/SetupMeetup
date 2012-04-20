class EventsController < ApplicationController
  inherit_resources
  before_filter :authenticate_user!, except: :show

  def create
    @event = current_user.owned_events.build params[:event]
    create!
  end

  def join
    resource.add_participant(current_user)
    redirect_to resource
  end
end
