require 'spec_helper'

describe "landing/index" do
  before do
    view.stub events: []
    view.stub user_signed_in?: false
  end

  context "when there are no events" do
    it "should display 'No events yet'" do
      view.stub(events: [])
      render
      rendered.should have_content "There are no events yet"
    end
  end

  context "when there are many events", pending: "Spin bug" do
    it "should display all of them" do
      view.stub(events: [ stub(name: "event 1", date: Time.now),
                          stub(name: "event 2", date: Time.now + 1.day) ])
      render
      rendered.should_not have_content "There are no events yet"
      rendered.should have_content "event 1"
      rendered.should have_content "event 2"
    end
  end

  context "when there is a logged in user", pending: "Spin bug" do
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
