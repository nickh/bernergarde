class AddTitle < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string :code, :description
    end
  end

  def self.down
    drop_table :titles
  end
end
