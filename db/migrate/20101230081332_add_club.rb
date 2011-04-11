class AddClub < ActiveRecord::Migration
  def self.up
    create_table :clubs do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :clubs
  end
end
