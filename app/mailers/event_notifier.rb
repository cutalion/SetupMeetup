class EventNotifier < ActionMailer::Base
  default from: "info@setupmeetup.com"

  def new_event(event, user)
    @event = event
    mail(subject: "New Event", to: user.email)
  end

  def time_changed(event, user)
    @event = event
    mail(subject: "Time of #{@event.name} was changed", to: user.email)
  end
end
