require 'spec_helper'

describe EventObserver do
  let(:user)  { stub(:user, email: "bob@example.com")  }
  let(:event) { stub(:event).as_null_object }
  let(:mail)  { stub(:mail)  }

  it "should notify all users about new event" do
    User.stub all: [user]

    EventNotifier.should_receive(:event_created).with(event, user).and_return(mail)
    mail.should_receive :deliver

    EventObserver.instance.after_create event
  end

  describe "notification about changed date" do
    it "should notify participants about changed date of the event" do
      event.stub participants: [user], date_changed?: true
      EventNotifier.should_receive(:event_updated).with(event, user).and_return(mail)
      mail.should_receive :deliver

      EventObserver.instance.after_update event
    end

    it "actually calls EventNotifier#event_updated" do
      event.stub participants: [user], date_changed?: true
      EventObserver.instance.after_update event
      EventNotifier.deliveries.last.subject.should match "Changed"
    end

    it "should not notify participants if date wasn't changed" do
      event.stub participants: [user], date_changed?: false
      EventObserver.instance.after_update event
      EventNotifier.deliveries.should be_empty
    end
  end


  pending "should notify participants about changed time of event"
  pending "should notify participants about changed place of event"
  pending "should notify participants about cancelled/deleted event"
end
