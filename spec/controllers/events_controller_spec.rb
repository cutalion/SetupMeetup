require 'spec_helper'

describe EventsController do
  [:new, :create, :edit, :update, :destroy].each do |action|
    it { should require_authentication_for action }
  end
end
