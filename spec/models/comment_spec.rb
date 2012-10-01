require 'spec_helper'

describe Comment do

  it { should validate_presence_of :body }
  it { should validate_presence_of :owner }

  it { should belong_to :owner }

end
