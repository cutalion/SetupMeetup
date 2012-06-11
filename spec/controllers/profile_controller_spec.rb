require 'spec_helper'

describe ProfileController do

  describe "GET 'show'" do
    context 'non-authorized user' do
      before { get 'show' }
      it { should redirect_to new_user_session_url }
    end

    context 'authorized user' do
      let(:user) { FactoryGirl.create :user }
      before { sign_in user }
      before { get 'show' }
      it { response.should render_template("show") }
    end
  end

end
