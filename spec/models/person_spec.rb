require 'spec_helper'

describe Person do
  attrs = {
    'first_name'       => :string,
    'last_name'        => :string,
    'second_name'      => :string,
    'country'          => :string,
    'address'          => :string,
    'address2'         => :string,
    'email'            => :string,
    'phone'            => :string,
    'fax'              => :string,
    'web_site'         => :string,
    'kennel_name'      => :string,
    'bmdca_status'     => :string,
    'deceased'         => :boolean,
    'master_household' => :boolean,
    'data_source'      => :string,
  }
  attrs.each do |attr, col_type|
    it "has a #{attr}" do
      subject.should have_attribute(attr => col_type)
    end
  end

  it 'has many dogs' do
    subject.should have_many :dogs
  end

  it 'has many litters' do
    subject.should have_many :litters
  end

  it 'has many clubs' do
    subject.should have_many :clubs, :through => :club_memberships
  end
end
