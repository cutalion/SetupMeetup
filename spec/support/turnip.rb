require "turnip/capybara"
RSpec.configure do |config|
  Turnip::Config.step_dirs = 'spec/step_definitions'
  Turnip::StepLoader.load_steps
end
