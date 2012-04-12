step "I'm guest on the site" do
end

step "I fill out email field only" do
  @guest = stub(:guest, email: "user@example.com", password: "password")

  visit "/users/sign_up"
  fill_in "Email", with: @guest.email
  click_button "Sign up"
end

step "I should be registered" do
  @user = User.last
  @user.email.should == @guest.email
end

step "I have a Facebook account" do
end

step "I have a Twitter account" do
end

step "I have a Google account" do
end

step 'I click "Sign in with Facebook" button' do
  visit "/"
  click_link "Sign in with Facebook"
end

step 'I click "Sign in with Twitter" button' do
  visit "/"
  click_link "Sign in with Twitter"
end

step 'I click "Sign in with Google" button' do
  visit "/"
  click_link "Sign in with Google"
end

step "I should be logged in with my facebook email" do
  User.last.email.should == OmniAuth.config.mock_auth[:facebook][:info][:email]
  page.should have_content greeting(User.last)
end

step "I should be logged in without email" do
  User.last.email.should be_blank
  page.should have_content greeting(User.last)
end

step "I should be logged in with my google email" do
  User.last.email.should == OmniAuth.config.mock_auth[:google][:info][:email]
  page.should have_content greeting(User.last)
end
