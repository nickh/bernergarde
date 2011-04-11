class Litter < ActiveRecord::Base
  belongs_to :sire,    :class_name => 'Dog', :foreign_key => :sire_id
  belongs_to :dam,     :class_name => 'Dog', :foreign_key => :dam_id
  belongs_to :breeder, :class_name => 'Person'
  has_many :dogs

  class MaleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << 'must be male' if value && value.female?
    end
  end
  class FemaleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << 'must be female' if value && value.male?
    end
  end
  validates :sire, :presence => true, :male   => true
  validates :dam,  :presence => true, :female => true
end
