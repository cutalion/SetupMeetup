class EventNotifier < ActionMailer::Base
  default from: "info@setupmeetup.com"

  def event_created(event, recipient)
    @event = event
    @recipient = recipient
    mail(subject: "New Meetup", to: recipient.email)
  end

  def event_updated(event, recipient, changed_attributes)
    @event = event
    @recipient = recipient
    mail(subject: "Meetup Information Changed", to: recipient.email)
  end

  def week_notification(event, recipient)
    @event = event
    mail(subject: "Reminder about #{event.name}", to: recipient.email)
  end
end
