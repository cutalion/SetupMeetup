require 'spec_helper'

describe Comment do

  it { should validate_presence_of :body }
  it { should validate_presence_of :owner }

  it { should belong_to :owner }

  describe 'can_be_deleted?' do
    let(:event_owner) { FactoryGirl.create(:user) }
    let(:comment_owner) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event, owner: event_owner) }
    let(:comment) { FactoryGirl.create(:comment, event: event, owner: comment_owner) }
    let(:visitor) { FactoryGirl.create(:user) }

    specify { comment.should      be_deletable_by event_owner }
    specify { comment.should      be_deletable_by comment_owner }
    specify { comment.should_not  be_deletable_by visitor }
  end
end
