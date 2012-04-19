require 'spec_helper'

describe EventOwnerObserver do
  it "should add event onwer to the list of event participants" do
    user  = stub(:user)
    event = stub(:event, owner: user)
    event.should_receive(:add_participant).with(event.owner)
    EventOwnerObserver.instance.after_create event
  end
end
