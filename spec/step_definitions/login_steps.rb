step "I'm registered user" do
  @user = FactoryGirl.create :user, password: "password"
end

step "I fill out login form" do
  visit "/users/sign_in"
  fill_in "Email", with: @user.email
  fill_in "Password", with: "password"
  click_button "Sign in"
end

step "I'm logging in with wrong credentials" do
  visit "/users/sign_in"
  click_button "Sign in"
end

step "I should be logged in" do
  page.should have_content greeting(@user)
end

step "I should be notified about invalid email or password" do
  page.should have_content "Invalid email or password"
end

