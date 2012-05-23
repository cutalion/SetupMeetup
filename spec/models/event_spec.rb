require 'spec_helper'

describe Event do
  it { should validate_presence_of :name  }
  it { should validate_presence_of :time  }
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
    before { Timecop.freeze Time.zone.local(2012, 01, 15, 13, 00) }
    after  { Timecop.return }

    it "should return events, which start in the future" do
      future_event = FactoryGirl.create :event, time: 1.second.from_now
      Event.future_events.should == [future_event]
    end
    it "should not return events, which start right now" do
      future_event = FactoryGirl.create :event, time: Time.zone.now
      Event.future_events.should == [future_event]
    end
    it "should not return events, which were in the past" do
      past_event = FactoryGirl.create :event, time: 1.second.ago
      Event.future_events.should == []
    end
  end

  describe ".events_within_a_week" do
    before { Timecop.freeze Time.zone.local(2012, 01, 15, 13, 00) }
    after  { Timecop.return }

    it "should return events, which start within 7 days" do
      future_event = FactoryGirl.create :event, time: 7.days.from_now
      Event.events_within_a_week.to_a.should == [future_event]
    end

    it "should not return events, which start within 6 days" do
      future_event = FactoryGirl.create :event, time: 6.days.from_now
      Event.events_within_a_week.to_a.should == []
    end

    it "should not return events, which start within 8 days" do
      future_event = FactoryGirl.create :event, time: 8.days.from_now
      Event.events_within_a_week.to_a.should == []
    end
  end

  describe ".today_events" do
    before { Timecop.freeze Time.zone.local(2012, 01, 15, 13, 00) }
    after  { Timecop.return }

    it "should return events, which start today" do
      future_event = FactoryGirl.create :event, time: Time.zone.now
      Event.today_events.to_a.should == [future_event]
    end

    it "should not return events, which start yesterday" do
      FactoryGirl.create :event, time: 1.day.ago
      Event.today_events.to_a.should == []
    end

    it "should not return events, which start within 1 day" do
      FactoryGirl.create :event, time: 1.day.from_now
      Event.today_events.to_a.should == []
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
    Mongoid.observers.enable(:all)

    event = FactoryGirl.create :event
    event.participants.should include event.owner
  end

  describe "#important_information_changed?" do
    let(:event) { Event.new }

    specify { event.important_information_changed?.should be_false }
    specify do
      event.time = Time.now
      event.important_information_changed?.should be_true
    end
    specify do
      event.address = "New Address"
      event.important_information_changed?.should be_true
    end
  end

  describe "#owned_by?" do
    let(:event) { Event.new }
    let(:owner) { stub }
    let(:user)  { stub }
    before { event.stub owner: owner }

    specify { event.owned_by?(owner).should be_true }
    specify { event.owned_by?(user).should be_false }

    context "nil" do
      specify "returns false if owner isn't nil" do
        event.owned_by?(nil).should be_false
      end
      specify "returns false if owner is nil" do
        event.stub owner: nil
        event.owned_by?(nil).should be_false
      end
    end
  end
end
