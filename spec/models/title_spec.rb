require 'spec_helper'

describe Title do
  it 'has a code' do
    subject.should have_attribute('code' => :string)
  end

  it 'has a description' do
    subject.should have_attribute('description' => :string)
  end
end
