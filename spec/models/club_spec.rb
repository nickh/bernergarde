require 'spec_helper'

describe Club do
  it 'has a name' do
    subject.should have_attribute('name' => :string)
  end

  it 'has many members' do
    subject.should have_many :members, :through => :club_memberships
  end
end
