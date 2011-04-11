class AddDog < ActiveRecord::Migration
  def self.up
    create_table :dogs do |t|
      t.integer :litter_id, :owner_id
      t.string  :registered_name, :call_name, :registration, :registry, :registration2, :registry2, :dna_registration, :data_source
      t.boolean :female, :neutered, :frozen_semen
      t.date    :stud_book_date, :deceased_at
      t.string  :data_source
      t.timestamps
    end
  end

  def self.down
    drop_table :dogs
  end
end
