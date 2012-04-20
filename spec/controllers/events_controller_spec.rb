require 'spec_helper'

describe EventsController do
  let(:event) { FactoryGirl.create :event }

  [:new, :create, :edit, :update, :destroy].each do |action|
    it { should require_authentication_for action }
  end

  it { should_not require_authentication_for :show, id: event.id }

  pending "show"
end
