RSpec.configure do |config|
  config.before(:suite) do
    Mongoid.observers.disable :all
  end
end

class TestObsreverActivator
  def initialize(observer_class)
    @observer_class = observer_class
  end

  def for(model_class)
    model_class.observers.should_receive(:disabled_for?).with(@observer_class.instance).and_return(false)
    Mongoid.observers.should_receive(:disabled_for?).with(@observer_class.instance).and_return(false)
  end
end

def enable_observer(observer_class)
  TestObsreverActivator.new observer_class
end
