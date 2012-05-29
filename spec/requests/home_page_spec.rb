require 'spec_helper'

describe "Home Page" do
  context "when there are no events" do
    it "should display 'No events yet'" do
      visit "/"
      page.should have_content "There are no future events yet"
    end
  end
end
