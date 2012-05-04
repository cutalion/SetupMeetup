class Generate < Thor
  require './config/environment'

  desc :event, "generate event with participants"
  def event
    event_attributes = {
      name: "Meetup",
      description: "Some description",
      date: Date.today + 7,
      time: Time.parse('18:00')
    }

    user_attributes = {
      name: 'Event owner',
      email: 'user@example.org',
      password: 'password'
    }

    @user = User.first conditions: {email: user_attributes[:email]}
    @user ||= User.create! user_attributes
    @event = @user.owned_events.create event_attributes

    20.times do |n|
      new_user_attributes = user_attributes.clone
      new_user_attributes[:email] = Faker::Internet.email
      new_user_attributes[:name] = Faker::Name.name
      @new_user = User.create new_user_attributes
      @event.participants << @new_user
    end
  end
end