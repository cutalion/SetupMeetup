require 'spec_helper'

describe EventObserver do
  let(:user)  { stub(:user)  }
  let(:event) { stub(:event) }
  let(:mail)  { stub(:mail)  }

  it "should notify all users about new event" do
    User.stub all: [user]

    EventNotifier.should_receive(:new_event).with(event, user).and_return(mail)
    mail.should_receive :deliver

    EventObserver.instance.after_create event
  end

  pending "should notify participants about changed date of event"
  pending "should notify participants about changed time of event"
  pending "should notify participants about changed place of event"
  pending "should notify participants about cancelled/deleted event"
end
