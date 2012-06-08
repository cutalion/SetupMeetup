require 'spec_helper'

describe Users::OmniauthCallbacksController do
  describe "facebook callback with logged user" do
    before {
      @user = FactoryGirl.create(:user)
      @user.authorizations << u = FactoryGirl.create(:authorization, provider: 'Something')
    }

    before { controller.stub :current_user => @user }
    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook] }
    before { request.env["devise.mapping"] = Devise.mappings[:user] }

    before { get :facebook }
    it { should redirect_to root_url }
    it "should relate facebook authorization with current user" do
      @user.authorizations.count.should         eql 2
      @user.authorizations.last.provider.should eql 'facebook'
    end
  end

  describe "facebook callback" do
    let(:user) { User.new }

    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook] }
    before { request.env["devise.mapping"] = Devise.mappings[:user] }
    before { User.should_receive(:find_or_create_with_oauth).and_return(user) }

  
    context "if user persisted" do
      before { user.stub :persisted? => true }
      before { get :facebook }
      it { should redirect_to root_path } 
      specify { flash[:notice].should match /successfully authorized/i }
    end
  
    context "if user not persisted" do
      before { user.stub :persisted? => false }
      before { get :facebook }
      it { should redirect_to new_user_registration_path } 
      it "should store omniauth data for later usage in session" do
        session["devise.oauth_data"].should == request.env["omniauth.auth"]
      end
    end
  end


  describe "twitter callback" do
    let(:user) { User.new }

    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter] }
    before { request.env["devise.mapping"] = Devise.mappings[:user] }
    before { User.should_receive(:find_or_create_with_oauth).and_return(user) }

  
    context "if user persisted" do
      before { user.stub :persisted? => true }
      before { get :twitter }
      it { should redirect_to root_path } 
      specify { flash[:notice].should match /successfully authorized/i }
    end
  
    context "if user not persisted" do
      before { user.stub :persisted? => false }
      before { get :twitter }
      it { should redirect_to new_user_registration_path } 
      it "should store omniauth data for later usage in session" do
        session["devise.oauth_data"].should == request.env["omniauth.auth"]
      end
    end
  end


  describe "google callback" do
    let(:user) { User.new }

    before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google] }
    before { request.env["devise.mapping"] = Devise.mappings[:user] }
    before { User.should_receive(:find_or_create_with_oauth).and_return(user) }

  
    context "if user persisted" do
      before { user.stub :persisted? => true }
      before { get :google }
      it { should redirect_to root_path } 
      specify { flash[:notice].should match /successfully authorized/i }
    end
  
    context "if user not persisted" do
      before { user.stub :persisted? => false }
      before { get :google }
      it { should redirect_to new_user_registration_path } 
      it "should store omniauth data for later usage in session" do
        session["devise.oauth_data"].should == request.env["omniauth.auth"]
      end
    end
  end
end
