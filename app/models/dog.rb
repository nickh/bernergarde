class Dog < ActiveRecord::Base
  include AnyMatcher

  belongs_to :owner, :class_name => 'Person'
  belongs_to :litter
  has_many :litters,
           :finder_sql => proc {"SELECT litters.* FROM litters WHERE #{litter_foreign_key}=#{id}"},
           :before_add => :set_litter_parent
  has_many :completed_titles
  has_many :completed_certifications
  has_many :diagnoses

  delegate :breeder, :whelp_date, :sire, :dam, :to => :litter, :allow_nil => true

  def male?
    !self.female?
  end

  def siblings(kind)
    if sire.nil? || dam.nil?
      litters = []
    else
      litters = case kind
                when :full
                  Litter.where(:sire_id => sire, :dam_id => dam)
                when :sire
                  Litter.where(:sire_id => sire).where(['dam_id != ?', dam])
                when :dam
                  Litter.where(:dam_id => dam).where(['sire_id != ?', sire])
                end
    end

    litters.map{|litter| litter.dogs}.flatten
  end

  private

    def litter_foreign_key
      self.female?? 'dam_id' : 'sire_id'
    end

    def set_litter_parent(litter)
      litter.update_attribute(litter_foreign_key, self.id)
    end
end
