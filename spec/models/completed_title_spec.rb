require 'spec_helper'

describe CompletedTitle do
  attrs = {
    'completed_at' => :date,
    'verified'     => :boolean,
    'comments'     => :string,
  }
  attrs.each do |attr, col_type|
    it "has a #{attr}" do
      subject.should have_attribute(attr => col_type)
    end
  end

  it 'belongs to a dog' do
    subject.should belong_to :dog
  end

  it 'belongs to a title' do
    subject.should belong_to :title
  end
end
