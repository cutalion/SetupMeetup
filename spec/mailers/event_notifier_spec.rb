require "spec_helper"

describe EventNotifier do
  describe "#event_created" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    let(:user)  { User.new email: "bob@example.com" }
    subject { EventNotifier.event_created(event, user) }

    its(:to)      { should == [user.email] }
    its(:subject) { should match /New Event/ }
    its(:body)    { should match event.description }
  end

  describe "#event_updated" do
    let(:event) { Event.new description: "Huray!\nNew Meetup!" }
    let(:user)  { User.new email: "bob@example.com" }
    subject { EventNotifier.event_updated(event, user) }

    its(:to)      { should == [user.email] }
    its(:subject) { should match /Event Information Changed/ }

    context "when date is changed" do
      before do
        event.stub date_changed?: true
        event.date = Date.new(2012, 5, 5)
      end
      its(:body) { should match "New date is 2012-05-05" }
    end
  end
end
