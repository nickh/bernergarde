class SplitAddress < ActiveRecord::Migration
  def self.up
    add_column :people, :city,  :string
    add_column :people, :state, :string
    add_column :people, :zip,   :string
  end

  def self.down
    remove_column :people, :city
    remove_column :people, :state
    remove_column :people, :zip
  end
end
