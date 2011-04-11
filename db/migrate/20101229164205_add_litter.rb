class AddLitter < ActiveRecord::Migration
  def self.up
    create_table :litters do |t|
      t.integer :breeder_id, :sire_id, :dam_id
      t.date :whelp_date
    end
  end

  def self.down
    drop_table :litters
  end
end
