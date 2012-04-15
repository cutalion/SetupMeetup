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
end
