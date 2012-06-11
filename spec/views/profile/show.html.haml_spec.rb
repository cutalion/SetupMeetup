require 'spec_helper'

describe "profile/show" do
  let(:user) { FactoryGirl.create :user }

  before { view.stub current_user: user }

  context 'when user have only one related provider' do
    before { user.authorizations << FactoryGirl.create(:authorization, provider: 'google') }
    before { render }
    it { 
      rendered.should have_selector 'td.related-providers a.btn.btn-primary.disabled', 
                                    content: 'Google',
                                    href: '#'
    }
    it 'should have allowed providers' do
      rendered.should have_selector 'td.allowed-providers a.btn.btn-primary', 
                                    content: 'Twitter'
      rendered.should have_selector 'td.allowed-providers a.btn.btn-primary', 
                                    content: 'Facebook'
    end
  end

  context 'when user have 3 related providers' do
    before { 
      user.authorizations << FactoryGirl.create(:authorization, provider: 'google')
      user.authorizations << FactoryGirl.create(:authorization, provider: 'twitter')
      user.authorizations << FactoryGirl.create(:authorization, provider: 'facebook')
    }
    before { render }
    it 'should have not allowed providers' do
      rendered.should_not have_selector 'td.allowed-providers'
    end
    it 'should have assigned providers' do
      rendered.should have_selector 'td.related-providers a.btn.btn-primary', 
                                    content: 'Twitter',
                                    href: users_authorization_url('twitter'),
                                    method: :delete
      rendered.should have_selector 'td.related-providers a.btn.btn-primary', 
                                    content: 'Facebook',
                                    href: users_authorization_url('facebook'),
                                    method: :delete
      rendered.should have_selector 'td.related-providers a.btn.btn-primary', 
                                    content: 'Google',
                                    href: users_authorization_url('google'),
                                    method: :delete
    end
  end
end
