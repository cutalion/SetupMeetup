step "I'm a signed in user" do
  ApplicationController.any_instance.stub(:current_user).and_return(@user = FactoryGirl.create(:user))
end

step "I click logout" do
  visit '/'
  click_link "Sign out"
end

step "I should be logged out" do
  pending "No idea how to test this one yet. Requires making calls to navigator.id"
  # page.should_not have_content greeting(@user)
end
