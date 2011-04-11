class AddCompletedTitle < ActiveRecord::Migration
  def self.up
    create_table :completed_titles do |t|
      t.integer :dog_id, :title_id
      t.boolean :verified
      t.date    :completed_at
      t.string  :comments
    end
  end

  def self.down
    drop_table :completed_titles
  end
end
