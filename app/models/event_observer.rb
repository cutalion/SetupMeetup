class EventObserver < Mongoid::Observer
  def after_create(event)
    User.all.each do |user|
      EventNotifier.delay.event_created(event, user)
    end
  end

  def after_update(event)
    if event.important_information_changed?
      event.participants.each do |user|
        EventNotifier.delay.event_updated(event, user, event.changed)
      end
    end
  end
end
