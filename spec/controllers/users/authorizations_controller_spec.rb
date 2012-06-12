require 'spec_helper'

describe Users::AuthorizationsController do

  describe "DELETE 'destroy'" do
    let(:user) { FactoryGirl.create :user }
    before {
      user.authorizations << FactoryGirl.create(:authorization, provider: 'google')
      user.authorizations << FactoryGirl.create(:authorization, provider: 'twitter')
    }
    it { user.authorizations.count.should eql 2 }

    context 'non-authorized user' do
      before { get 'destroy', id: 'google' }
      it { should redirect_to new_user_session_url }
    end

    context 'authorized author' do
      before { sign_in user }
      before { get 'destroy', id: 'google' }
      it { should redirect_to user_profile_url }
      it "should destroy authorization" do
        user.authorizations.count.should eql 1
        user.authorizations.where(provider: 'google').count.should eql 0
      end
    end
  end

end
