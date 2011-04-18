class Person < ActiveRecord::Base
  has_many :dogs,             :foreign_key => 'owner_id'
  has_many :litters,          :foreign_key => 'breeder_id'
  has_many :club_memberships, :foreign_key => 'member_id'
  has_many :clubs,            :through => :club_memberships

  scope :matching_any, lambda {|conditions|
    match_string = '%%%s%%'
    table = unscoped.table
    column,val = conditions.shift
    base = table[column].matches(match_string % val)
    where(conditions.inject(base) do |where_clause, match|
      column,val = match
      where_clause.or(table[column].matches(match_string % val))
    end)
  }
end
