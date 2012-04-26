class EventObserver < Mongoid::Observer
  def after_create(event)
    User.all.each do |user|
      EventNotifier.new_event(event, user).deliver
    end
  end
end
