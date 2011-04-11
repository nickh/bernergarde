class Dog < ActiveRecord::Base
  belongs_to :owner, :class_name => 'Person'
  belongs_to :litter
  has_many :litters,
           :finder_sql => 'SELECT litters.* FROM litters WHERE #{litter_foreign_key}=#{id}',
           :before_add => :set_litter_parent
  has_many :completed_titles
  has_many :completed_certifications
  has_many :diagnoses

  def male?
    !self.female?
  end

  private

    def litter_foreign_key
      self.female?? 'dam_id' : 'sire_id'
    end

    def set_litter_parent(litter)
      litter.update_attribute(litter_foreign_key, self.id)
    end
end
