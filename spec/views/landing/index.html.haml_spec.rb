require 'spec_helper'

describe "landing/index" do
  before do
    view.stub future_events: []
    view.stub past_events: []
    view.stub user_signed_in?: false
  end

  context "when there are no future events" do
    it "should display 'No events yet'" do
      view.stub(future_events: [])
      render
      rendered.should have_content "There are no future events yet"
    end
  end

  context "when there are many future events" do
    it "should display all of them" do
      view.stub(future_events: [ stub(name: "event 1", date: Time.now),
                          stub(name: "event 2", date: Time.now + 1.day) ])
      render
      rendered.should_not have_content "There are no future events yet"
      rendered.should have_content "event 1"
      rendered.should have_content "event 2"
    end
  end

  context "when there are past events" do
    it "should display all of them" do
      view.stub(past_events: [ stub(name: "event 1", date: Time.now),
                          stub(name: "event 2", date: Time.now + 1.day) ])
      render
      rendered.should have_content "event 1"
      rendered.should have_content "event 2"
    end
  end

  context "when there is a logged in user" do
    it "should show 'Create Event' button" do
      view.stub user_signed_in?: true
      render
      rendered.should have_content "Create event"
    end
  end

  context "when there is a guest" do
    it "should not show 'Create Event' button" do
      view.stub user_signed_in?: false
      render

      rendered.should_not have_button "Create event"
    end
  end
end
