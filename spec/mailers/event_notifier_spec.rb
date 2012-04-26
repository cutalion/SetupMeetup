require "spec_helper"

describe EventNotifier do
  describe "#new_event" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    let(:user)  { User.new email: "bob@example.com" }
    subject { EventNotifier.new_event(event, user) }

    its(:to)      { should == [user.email] }
    its(:subject) { should match /New Event/ }
    its(:body)    { should match event.description }
  end
end
