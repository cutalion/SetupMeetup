require 'spec_helper'

describe PersonaController do

  describe 'login' do
    context 'valid load' do
      let(:email) { 'user@email.com' }
      let(:data)  { { 'status' => 'okay', 'email' => email } }
      let(:user)  { FactoryGirl.create(:user, email: email) }

      before  { controller.should_receive(:validate_assertion).with('assertion').and_return(data) }
      before  { User.should_receive(:find_or_create_by).with(email: email).and_return(user) }
      before  { controller.should_receive(:current_user=).with(user) }
      before  { post :login, assertion: 'assertion', format: 'json' }
      specify { response.body.should == data.to_json }
    end

    context 'invalid load' do
      let(:data) { { 'status' => 'error' } }

      before  { controller.should_receive(:validate_assertion).and_return(data) }
      before  { controller.should_not_receive(:find_or_create_by) }
      before  { post :login, assertion: 'assertion', format: 'json' }
      specify { response.body.should == data.to_json }
    end
  end

  describe 'logout' do
    before  { controller.should_receive(:current_user=).with(nil) }
    before  { post :logout }
    specify { response.body.should == '' }
  end

end
