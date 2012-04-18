require 'spec_helper'

describe Event do
  it { should validate_presence_of :name  }
  it { should validate_presence_of :date  }
  it { should validate_presence_of :owner }

  it { should belong_to :owner }

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
end
