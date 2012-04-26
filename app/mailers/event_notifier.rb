class EventNotifier < ActionMailer::Base
  default from: "info@setupmeetup.com"

  def new_event(event, user)
    @event = event
    mail(subject: "New Event", to: user.email)
  end
end
