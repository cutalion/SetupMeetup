require 'spec_helper'

describe Event do
  it { should validate_presence_of :name  }
  it { should validate_presence_of :date  }
  it { should validate_presence_of :owner }

  it { should belong_to :owner }
  it { should have_and_belong_to_many :participants }

  specify ":owner should not be accessible through mass-assignment" do
    event = Event.new owner: mock_model(User)
    event.owner.should be_nil

    event = Event.new owner_id: 1
    event.owner_id.should be_nil
  end

  describe ".future_events" do
    it "should return events, that start in the future" do
      future_event = FactoryGirl.create :event, date: 1.day.from_now
      Event.future_events.should == [future_event]
    end
    it "should return events, that start today" do
      today_event = FactoryGirl.create :event, date: Date.today
      Event.future_events.should == [today_event]
    end
    it "should not return events, that were in the past" do
      past_event = FactoryGirl.create :event, date: 1.day.ago
      Event.future_events.should == []
    end
  end

  describe "#add_participant" do
    let(:event) { Event.new }
    let(:user)  { User.new  }

    it "should add user to the list of participants" do
      event.add_participant user
      event.participant_ids.should include user.id
      user.event_ids.should include event.id
    end

    it "should not add participant twice" do
      event.add_participant user
      event.add_participant user
      event.participant_ids == [user.id]
      user.event_ids.should == [event.id]
    end
  end

  specify "owner should be participant of the event also" do
    enable_observer(EventOwnerObserver).for(Event)

    event = FactoryGirl.create :event
    event.participants.should include event.owner
  end
end
