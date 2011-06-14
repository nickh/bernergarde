class AddPersonDisplayContactInfo < ActiveRecord::Migration
  def self.up
    add_column :people, :display_contact_info, :boolean
  end

  def self.down
    remove_column :people, :display_contact_info
  end
end
