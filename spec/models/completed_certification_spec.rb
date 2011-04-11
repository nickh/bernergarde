require 'spec_helper'

describe CompletedCertification do
  attrs = {
    'certification_id' => :integer,
    'dog_id'           => :integer,
    'tested_at'        => :date,
    'certified_by'     => :string,
    'tested'           => :string,
    'identifier'       => :string,
    'findings'         => :string,
  }
  attrs.each do |attr, col_type|
    it "has a #{attr}" do
      subject.should have_attribute(attr => col_type)
    end
  end

  it 'belongs to a certification' do
    subject.should belong_to :certification
  end

  it 'belongs to a dog' do
    subject.should belong_to :dog
  end
end
