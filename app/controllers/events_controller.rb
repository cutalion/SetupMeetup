class EventsController < ApplicationController
  inherit_resources
  actions :all, except: [ :destroy ]
  before_filter :authenticate_user!, except: :show

  def create
    @event = current_user.owned_events.build params[:event]
    create!
  end

  def edit
    @event = current_user.owned_events.find params[:id]
    edit!
  end

  def update
    @event = current_user.owned_events.find params[:id]
    update!
  end

  def join
    resource.add_participant(current_user)
    redirect_to resource
  end
end
