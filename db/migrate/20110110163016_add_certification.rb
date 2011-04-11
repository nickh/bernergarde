class AddCertification < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
      t.string :name
      t.timestamps
    end

    create_table :completed_certifications do |t|
      t.integer :certification_id, :dog_id
      t.string :certified_by, :tested, :identifier, :findings
      t.date :tested_at
      t.timestamps
    end
  end

  def self.down
    drop_table :certifications
    drop_table :completed_certifications
  end
end
