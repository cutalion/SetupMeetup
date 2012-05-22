require "spec_helper"

describe EventNotifier do
  let(:user)  { User.new email: "bob@example.com" }

  describe "#event_created" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    subject { EventNotifier.event_created(event, user) }

    its(:to)      { should == ["bob@example.com"] }
    its(:subject) { should match /New Event/ }
    its(:body)    { should match event.description }
  end

  describe "#event_updated" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    let(:user)  { User.new email: "bob@example.com" }
    subject { EventNotifier.event_updated(event, user, event.changed) }

    its(:to)      { should == [user.email] }
    its(:subject) { should match /Event Information Changed/ }

    context "when time of event changed" do
      before { event.time = Time.local 2012, 5, 3, 19, 00 }

      its(:body) { should match /New time is\s*May 03, Thursday\s*\/\s*19:00/   }
    end

    context "when address of event changed" do
      before { event.address = "McDonalds" }
      its(:body) { should match /New address is McDonalds/ }
    end
  end

  describe "#week_notification" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    subject { EventNotifier.week_notification(event, user) }

    its(:to)      { should == ["bob@example.com"] }
    its(:subject) { should match /Reminder/ }
    its(:body)    { should match event.description }
  end
end
