require 'spec_helper'

describe CommentsController do
  let(:user)  { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create :event, owner: user }

  describe "creating" do
    before { sign_in user }

    context 'as attendee' do
      before  { event.add_participant(user) }

      context 'valid comment' do
        before  { post :create, event_id: event.id, comment: { body: 'test' } }
        it      { should redirect_to event }

        it 'should create a comment' do
          event.comments.count.should == 1

          c = event.comments.first
          c.body.should  == 'test'
          c.owner.should == user
        end
      end

      context 'invalid comment' do
        before  { post :create, event_id: event.id }
        it      { should redirect_to event }
        specify { assigns(:comment).errors.full_messages.should_not be_empty }
      end
    end

    context 'as spectator' do
      before  { post :create, event_id: event.id }
      it      { should redirect_to event }
      specify { flash.alert.should == CommentsController::ATTENDEES_ONLY }
    end
  end


  describe "destroying" do
    let(:comment) { FactoryGirl.create(:comment, event: event) }

    before { sign_in user }

    context 'unknown comment' do
      before  { delete :destroy, id: 0 }
      it      { should redirect_to :root }
      specify { flash.alert.should == CommentsController::COMMENT_NOT_FOUND }
    end

    context 'deletable' do
      before  { controller.stub(:comment).and_return(comment) }
      before  { comment.should_receive(:deletable_by?).and_return(true) }
      before  { delete :destroy, id: comment.id }
      specify { event.comments.count.should == 0 }
    end

    context 'non-deletable' do
      before  { controller.stub(:comment).and_return(comment) }
      before  { comment.should_receive(:deletable_by?).and_return(false) }
      before  { delete :destroy, id: comment.id }
      it      { should redirect_to comment.event }
      specify { flash.alert.should == CommentsController::EVENT_OR_COMMENT_OWNER_ONLY }
    end
  end

end
