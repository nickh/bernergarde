require 'spec_helper'

describe Diagnosis do
  attrs = {
    'dog_id'       => :integer,
    'diagnosed_at' => :date,
    'summary'      => :string,
    'accuracy'     => :string,
    'location'     => :string,
    'metrical'     => :string,
  }
  attrs.each do |attr, col_type|
    it "has a #{attr}" do
      subject.should have_attribute(attr => col_type)
    end
  end

  it 'belongs to a dog' do
    subject.should belong_to :dog
  end
end
