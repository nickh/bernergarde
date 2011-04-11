class AddDiagnosis < ActiveRecord::Migration
  def self.up
    create_table :diagnoses do |t|
      t.integer :dog_id
      t.string :summary, :accuracy, :location, :metrical
      t.date :diagnosed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :diagnoses
  end
end
