require 'spec_helper'

describe EventsController do
  let(:user)  { FactoryGirl.create :user  }
  let(:event) { FactoryGirl.create :event, owner: user }

  [:new, :create, :edit, :update, :destroy].each do |action|
    it { should require_authentication_for action }
  end

  it { should_not require_authentication_for :show, id: event.id }

  describe "GET on edit" do
    before { sign_in user }

    context "by owner" do
      it "should respond with success" do 
        get :edit, id: event.id
        response.status.should == 200
      end
    end

    context "by not an owner" do
      let(:event) { FactoryGirl.create :event }
      it "should not update event" do 
        get :edit, id: event.id
        response.status.should == 404
      end
    end
  end

  describe "PUT on update" do
    before { sign_in user }

    context "by owner" do
      it "should update event and redirect to show" do 
        put :update, id: event.id
        should redirect_to event_path(event)
      end
    end

    context "by not an owner" do
      let(:event) { FactoryGirl.create :event }
      it "should not update event" do 
        put :update, id: event.id
        response.status.should == 404
      end
    end
  end
end
