class EventNotifier < ActionMailer::Base
  default from: "info@setupmeetup.com"

  def event_created(event, recipient)
    @event = event
    mail(subject: "New Event", to: recipient.email)
  end

  def event_updated(event, recipient)
    @event = event
    mail(subject: "Event Information Changed", to: recipient.email)
  end
end
