step "I'm guest on the site" do
end

step "I should be registered" do
  @user = User.last
  @user.email.should == @guest.email
end

step "I have a Google account" do
end

step 'I click "Sign in with email" button' do
  visit "/"
  click_link "Sign in with email"
end

step "I should be logged in with my google email" do
  # User.last.email.should == 'email'
  # page.should have_content greeting(User.last)
  pending "No idea how to test this one yet. Requires making calls to navigator.id"
end
