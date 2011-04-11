require 'spec_helper'

describe Certification do
  it 'has a name' do
    subject.should have_attribute('name' => :string)
  end
end
