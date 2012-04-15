require 'spec_helper'

describe "landing/index.html.haml" do
  context "when there are no events" do
    it "should display 'No events yet'" do
      view.stub(events: [])
      render
      rendered.should have_content "There are no events yet"
    end
  end

  context "when there are many events" do
    it "should display all of them" do
      view.stub(events: [ stub(name: "event 1"), 
                          stub(name: "event 2") ])
      render
      rendered.should_not have_content "There are no events yet"
      rendered.should have_content "event 1"
      rendered.should have_content "event 2"
    end
  end
end
