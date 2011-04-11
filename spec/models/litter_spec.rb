require 'spec_helper'

describe Litter do
  it 'belongs to a sire' do
    subject.should belong_to :sire
  end

  it 'belongs to a dam' do
    subject.should belong_to :dam
  end

  it 'belongs to a breeder' do
    subject.should belong_to :breeder
  end

  it 'has many dogs' do
    subject.should have_many :dogs
  end

  describe 'validation' do
    before(:each) do
      @dog   = Factory(:dog, :female => false)
      @bitch = Factory(:dog, :female => true)
    end

    it 'requires a dam' do
      Factory.build(:litter, :dam => nil).should have_errors_on(:dam)
    end

    it 'allows a female as the dam' do
      Factory.build(:litter, :dam => @bitch).should be_valid
    end

    it 'rejects a male as the dam' do
      Factory.build(:litter, :dam => @dog).should have_errors_on(:dam)
    end

    it 'requires a sire' do
      Factory.build(:litter, :sire => nil).should have_errors_on(:sire)
    end

    it 'allows a male as the sire' do
      Factory.build(:litter, :sire => @dog).should be_valid
    end

    it 'rejects a female as the sire' do
      Factory.build(:litter, :sire => @bitch).should have_errors_on(:sire)
    end
  end
end
