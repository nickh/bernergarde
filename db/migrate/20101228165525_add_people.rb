class AddPeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string  :name, :second_name, :country, :address, :address2, :email, :phone, :fax, :web_site, :kennel_name, :bmdca_status, :data_source
      t.boolean :deceased, :master_household
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
