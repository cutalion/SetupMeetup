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

    context "when date is changed" do
      before do
        event.stub date_changed?: true
        event.date = Date.new(2012, 5, 5)
      end
      its(:body) { should match "New date is 2012-05-05" }
    end

    context "when time of event changed" do
      before do
        event.stub time_changed?: true
        event.time = Time.local 2012, 5, 3, 19, 00 
      end

      its(:body) { should match /New time is 19:00/   }
    end
  end
end
