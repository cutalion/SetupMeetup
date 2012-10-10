require 'spec_helper'

describe User do
  let(:user) { double(:user).as_null_object }

  it { should have_many :owned_events }
  it { should have_and_belong_to_many :events }
  it { should validate_presence_of :email }

  it "should have default name if name is not specified" do
    user = FactoryGirl.create :user, name: ""
    user.name.should == user.email
  end

  pending "should recieve welcome email after create" do
    user = Factory.build :user
    mail = stub
    Notifier.should_receive(:welcome).with(user).and_return(mail)
    mail.should_receive(:deliver)
    user.save
  end

  describe "#start_event" do
    let(:user) { FactoryGirl.create :user }
    before { @event = user.start_event FactoryGirl.attributes_for(:event) }

    it "should create new event" do
      @event.should be_persisted
    end

    it "should be an owner of the created event" do
      @event.owner.should == user
    end
  end
end
