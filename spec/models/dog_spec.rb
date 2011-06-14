require 'spec_helper'

describe Dog do
  attrs = {
    'registered_name'  => :string,
    'call_name'        => :string,
    'female'           => :boolean,
    'neutered'         => :boolean,
    'registration'     => :string,
    'registry'         => :string,
    'registration2'    => :string,
    'registry2'        => :string,
    'dna_registration' => :string,
    'stud_book_date'   => :date,
    'deceased_at'      => :date,

    'frozen_semen'     => :boolean,
    'data_source'      => :string,
  }
  attrs.each do |attr, col_type|
    it "has a #{attr}" do
      subject.should have_attribute(attr => col_type)
    end
  end

  it 'belongs to an owner' do
    subject.should belong_to :owner
  end

  it 'belongs to a litter' do
    subject.should belong_to :litter
  end

  it 'has many completed titles' do
    subject.should have_many :completed_titles
  end

  it 'has many completed certifications' do
    subject.should have_many :completed_certifications
  end

  it 'has many diagnoses' do
    subject.should have_many :diagnoses
  end

  context 'when male' do
    it 'has many litters as the sire' do
      dog = Factory(:dog, :female => false)
      litter = dog.litters.build
      litter.sire.should == dog
    end
  end

  context 'when female' do
    it 'has many litters as the dam' do
      bitch = Factory(:dog, :female => true)
      litter = bitch.litters.build
      litter.dam.should == bitch
    end
  end

  describe 'delegations to litter' do
    before(:all) do
      @litter = Factory.build(:litter)
      @dog    = Factory.build(:dog, :litter => @litter)
    end

    it 'delegates breeder' do
      @dog.breeder.should == @litter.breeder
    end

    it 'delegates whelp_date' do
      @dog.whelp_date.should == @litter.whelp_date
    end
  end

  it 'matches any' do
    Dog.should respond_to :matching_any
  end
end
