def sign_in(user)
  if defined? session
    # functional testing
    session['uid'] = user.try(:id)
  elsif defined? page
    # acceptance testing
    page.cookies['test_uid'] = user.try(:id)
  end
end
