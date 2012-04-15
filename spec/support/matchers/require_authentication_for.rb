RSpec::Matchers.define :require_authentication_for do |action|
  match do |controller|
    send verb_for(action), action
    response.redirect_url =~ /sign_in/
  end

  failure_message_for_should do |controller|
    "expected that #{controller} requires authentication on :#{action} action"
  end

  failure_message_for_should_not do |controller|
    "expected that #{controller} does not require authentication on :#{action} action"
  end

  def verb_for(action)
    {
      new:      :get,
      edit:     :get,
      create:   :post,
      update:   :put,
      destroy:  :delete
    }[action]
  end
end
