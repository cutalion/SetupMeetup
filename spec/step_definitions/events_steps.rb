step "click \"Create event\" button" do
  click_link "Create event"
end

step "fill out event form" do
  fill_in "Name",         with: "New Rails Meetup"
  fill_in "Description",  with: "Hey guys, new meetup is on next Thursday"
  select  "2012",         from: "event_date_1i"
  select  "May",          from: "event_date_2i"
  select  "5",            from: "event_date_3i"
  select  "18",           from: "event_time_4i"
  select  "30",           from: "event_time_5i"
  click_button "Create Event"
end

step "new event should be created" do
  page.should have_content "successfully created"
end

step "I should see new event" do
  last_event = Event.last
  page.should have_content last_event.name
  page.should have_content last_event.description
end

step "I'm on the event page" do
  @event ||= FactoryGirl.create :event
  visit event_path(@event)
end

step "I join the event" do
  click_link "Join"
end

step "I should be in the participants list" do
  within(".participants") do
    page.should have_content @user.name
  end
end
