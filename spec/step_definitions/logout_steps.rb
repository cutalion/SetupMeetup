step "I'm a signed in user" do
  step "I'm registered user"
  step "I click \"Sign in with Google\" button"
end

step "I click logout" do
  click_link "Sign out"
end

step "I should be logged out" do
  page.should_not have_content greeting(@user)
end
