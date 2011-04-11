class AddClubMembership < ActiveRecord::Migration
  def self.up
    create_table :club_memberships do |t|
      t.integer :club_id, :member_id
    end
  end

  def self.down
    drop_table :club_memberships
  end
end
