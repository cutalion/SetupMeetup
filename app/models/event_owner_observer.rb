class EventOwnerObserver < Mongoid::Observer
  observe :event

  def after_create(event)
    event.add_participant event.owner
  end
end
