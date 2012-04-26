class EventObserver < Mongoid::Observer
  def after_create(event)
    User.all.each do |user|
      EventNotifier.event_created(event, user).deliver
    end
  end

  def after_update(event)
    if event.date_changed?
      event.participants.each do |user|
        EventNotifier.event_updated(event, user).deliver
      end
    end
  end
end
