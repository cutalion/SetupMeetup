require 'spec_helper'

describe "Home Page" do
  context "when there are no user groups" do
    it "should display 'No User Groups yet'" do
      visit "/"
      page.should have_content "There are no user groups yet"
    end
  end
end
