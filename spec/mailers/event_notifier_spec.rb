require "spec_helper"

describe EventNotifier do
  let(:user)  { User.new email: "bob@example.com" }
  describe "#new_event" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    subject { EventNotifier.new_event(event, user) }

    its(:to)      { should == ["bob@example.com"] }
    its(:subject) { should match /New Event/ }
    its(:body)    { should match event.description }
  end

  describe "time of event changed" do
    let(:event) { Event.new name: "Event with strange time" }
    subject { EventNotifier.time_changed(event, user) }

    its(:to)      { should == ["bob@example.com"] }
    its(:subject) { should match /Time of Event with strange time was changed/   }
    its(:body)    { should match /strange time/   }
  end
end
