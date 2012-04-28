class EventObserver < Mongoid::Observer
  def after_create(event)
    User.all.each do |user|
      EventNotifier.new_event(event, user).deliver
    end
  end

  def after_update(event)
    return unless event.date_changed?
    User.all.each do |user|
      EventNotifier.time_changed(event, user).deliver
    end
  end
end
