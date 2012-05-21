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

  describe '#siblings' do
    before do
      sire       = Factory(:dog, :female => false)
      dam        = Factory(:dog, :female => true)
      other_sire = Factory(:dog, :female => false)
      other_dam  = Factory(:dog, :female => true)

      full_litter      = Factory(:litter, :sire => sire, :dam => dam)
      half_sire_litter = Factory(:litter, :sire => sire, :dam => other_dam)
      half_dam_litter  = Factory(:litter, :sire => other_sire, :dam => dam)

      @dog               = Factory(:dog, :litter => full_litter)
      @full_sibling      = Factory(:dog, :litter => full_litter)
      @half_sire_sibling = Factory(:dog, :litter => half_sire_litter)
      @half_dam_sibling  = Factory(:dog, :litter => half_dam_litter)
    end

    context 'full' do
      before do
        @siblings = @dog.siblings(:full)
      end

      it 'includes full siblings' do
        @siblings.should include(@full_sibling)
      end

      it 'does not include half siblings' do
        @siblings.should_not include(@half_sire_sibling)
        @siblings.should_not include(@half_dam_sibling)
      end
    end

    context 'half (sire)' do
      before do
        @siblings = @dog.siblings(:sire)
      end

      it 'includes half siblings through the sire' do
        @siblings.should include(@half_sire_sibling)
      end

      it 'does not include full siblings' do
        @siblings.should_not include(@half_dam_sibling)
      end

      it 'does not include half siblings through the dam' do
        @siblings.should_not include(@half_dam_sibling)
      end
    end

    context 'half (dam)' do
      before do
        @siblings = @dog.siblings(:dam)
      end

      it 'includes half siblings through the dam' do
        @siblings.should include(@half_dam_sibling)
      end

      it 'does not include full siblings' do
        @siblings.should_not include(@full_sibling)
      end

      it 'does not include half siblings through the sire' do
        @siblings.should_not include(@half_sire_sibling)
      end
    end
  end

  context 'when male' do
    it 'has many litters as the sire' do
      dog = Factory(:dog, :female => false)
      litter = Factory(:litter, :sire => dog)
      dog.litters.should include(litter)
    end
  end

  context 'when female' do
    it 'has many litters as the dam' do
      bitch = Factory(:dog, :female => true)
      litter = Factory(:litter, :dam => bitch)
      bitch.litters.should include(litter)
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

    it 'delegates sire' do
      @dog.sire.should == @litter.sire
    end

    it 'delegates dam' do
      @dog.dam.should == @litter.dam
    end
  end

  it 'matches any' do
    Dog.should respond_to :matching_any
  end
end
