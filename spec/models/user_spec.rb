require 'spec_helper'

describe User do
  let(:user)         { double(:user).as_null_object }
  let(:access_token) { OmniAuth.config.mock_auth[:facebook]  }

  it { should have_many :authorizations }
  it { should validate_presence_of :email }

  it "should validate uniqueness of name" do
    FactoryGirl.create :user, :name => 'nick'
    should validate_uniqueness_of :name
  end

  it { should validate_format_of(:email).to_allow("user+suffix@example.com") }

  it "should generate temporary password if password is blank on create" do
    user = FactoryGirl.create :user, password: ""
    user.password.should_not be_blank
  end

  it "should not generate temporary password if password is blank on update" do
    user = FactoryGirl.create :user
    user.update_attributes(password: "")
    user.errors[:password].should include "can't be blank"
  end

  it "should have default name if name is not specified" do
    user = FactoryGirl.create :user, name: ""
    user.name.should == "User#{user.id}"
  end

  pending "should recieve welcome email after create" do
    user = Factory.build :user
    mail = stub
    Notifier.should_receive(:welcome).with(user).and_return(mail)
    mail.should_receive(:deliver)
    user.save
  end

  describe  ".find_or_create_with_oauth" do
    context "it can be found" do
      before { User.should_receive(:find_through_authorization).with(access_token).and_return(user) }

      it "should return found user" do
        User.find_or_create_with_oauth(access_token).should == user
      end

      it "should connect user with oauth provider" do
        user.should_receive(:connect_with_provider!).with(access_token)
        User.find_or_create_with_oauth(access_token)
      end
    end

    context "it cannot be found" do
      before { User.should_receive(:create_with_oauth).with(access_token).and_return(user) }
      it "should return new user" do
        User.find_or_create_with_oauth(access_token).should == user
      end
    end
  end

  describe ".create_with_auth" do
    it "should create new user from oath hash returned from twitter" do
      user = User.create_with_oauth(OmniAuth.config.mock_auth[:twitter])
      user.should be_persisted
      user.email.should be_blank
    end

    it "should create new user from oath hash returned from facebook" do
      user = User.create_with_oauth(OmniAuth.config.mock_auth[:facebook])
      user.should be_persisted
      user.email.should_not be_blank
    end
  end

  describe ".new_with_session" do
    let(:session) {{
      "devise.facebook_data" => { 
        "info" => { 
          "email" => "email+fromsession@example.com"
        }
      }
    }}

    it "should initialize user with email from session" do
      User.new_with_session({:email => 'email@example.com'}, session).email.should == "email+fromsession@example.com"
    end
  end

  describe "#connect_with_provider!" do
    let(:user) { FactoryGirl.create :user }
    before do
      @provider = stub :provider => "oauth provider", :uid => 'uid'
      @provider.stub_chain(:credentials, :token).and_return('token')
    end
    context "if not connected yet" do
      it "should create new authorization for that provider" do
        user.connect_with_provider! @provider
        user.authorizations.should have(1).authorization
      end
    end
    context "if connected already" do
      it "should duplicate authorization" do
        user.connect_with_provider! @provider
        user.connect_with_provider! @provider
        user.authorizations.should have(1).authorization
      end
    end
  end


  describe ".find_through_authorization" do
    let(:authorization) { stub :user => user }
    it "should find authorization and return associated user" do
      Authorization.should_receive(:find_by_provider_and_uid).with(access_token.provider, access_token.uid).and_return(authorization)
      User.find_through_authorization(access_token).should == user
    end
  end


  describe ".find_with_oauth" do
    let(:access_token) { stub(:info => stub(:email => email)) }

    context "if oauth data has email" do
      let(:email) { "user@example.com" }
      it "should find user by email" do
        User.should_receive(:find_by_email).with(email).and_return(user)
        User.find_with_oauth(access_token).should == user
      end
    end

    context "if oauth data has no email" do
      let(:email) { nil }
      it "should find user through authorization" do
        User.should_receive(:find_through_authorization).with(access_token).and_return(user)
        User.find_with_oauth(access_token).should == user
      end
    end

    context "if user not found by email" do
      let(:email) { "user@example.com" }
      it "should find user through authorization" do
        User.should_receive(:find_by_email).with(email).and_return(nil)
        User.should_receive(:find_through_authorization).with(access_token).and_return(user)
        User.find_with_oauth(access_token).should == user
      end
    end
  end
end
