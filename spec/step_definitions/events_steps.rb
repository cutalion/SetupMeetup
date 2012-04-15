step "click \"Create event\" button" do
  click_link "Create event"
end

step "fill out event form" do
  fill_in "Name",        with: "New Rails Meetup"
  fill_in "Description", with: "Hey guys, new meetup is on next Thursday"
  fill_in "Date",        with: "2012-04-05"
  fill_in "Time",        with: "18:30"
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
