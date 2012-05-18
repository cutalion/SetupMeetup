require 'spec_helper'

describe CronNotifier do
  before { Timecop.freeze Time.now }
  after  { Timecop.return }

  let(:user)  { stub }
  let(:event) { stub(participants: [user]) }


  describe ".send_weekly_notifications" do
    it "should send notifications to event participants a week before the event" do
      Event.stub events_within_a_week: [event]
      EventNotifier.should_receive(:delay).and_return(EventNotifier)
      EventNotifier.should_receive(:week_notification).with(event, user)
      CronNotifier.send_weekly_notifications
    end
  end

  describe ".send_today_notifications" do
    it "should send notifications to event participants at the event date" do
      Event.stub today_events: [event]
      EventNotifier.should_receive(:delay).and_return(EventNotifier)
      EventNotifier.should_receive(:today_notification).with(event, user)
      CronNotifier.send_today_notifications
    end
  end

  pending "should not send 'week before' notification twice"
  pending "should not send 'day before' notification twice"
end
