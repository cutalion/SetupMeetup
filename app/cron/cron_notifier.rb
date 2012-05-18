class CronNotifier
  def self.send_weekly_notifications
    Event.events_within_a_week.each do |event|
      event.participants.each do |user|
        EventNotifier.delay.week_notification(event, user)
      end
    end
  end
  def self.send_today_notifications
    Event.today_events.each do |event|
      event.participants.each do |user|
        EventNotifier.delay.today_notification(event, user)
      end
    end
  end
end
