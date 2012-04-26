RSpec.configure do |config|
  config.before(:each) do
    Mongoid.observers.disable(:all) unless example.metadata[:type] == :request
  end

  config.after(:each) do
    Mongoid.observers.enable(:all) unless example.metadata[:type] == :request
  end
end
