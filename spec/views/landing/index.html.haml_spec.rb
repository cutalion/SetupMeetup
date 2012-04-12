require 'spec_helper'

describe "landing/index.html" do
  context "when there are no user groups" do
    it "should display 'No User Groups yet'" do
      view.stub(user_groups: [])
      render
      rendered.should have_content "There are no user groups yet"
    end
  end

  context "when there are many user groups" do
    it "should display all of them" do
      view.stub(user_groups: [ stub(name: "User Group 1"), 
                               stub(name: "User Group 2") ])
      render
      rendered.should_not have_content "There are no user groups yet"
      rendered.should have_content "User Group 1"
      rendered.should have_content "User Group 2"
    end
  end
end
