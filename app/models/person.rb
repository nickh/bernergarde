class Person < ActiveRecord::Base
  has_many :dogs,             :foreign_key => 'owner_id'
  has_many :litters,          :foreign_key => 'breeder_id'
  has_many :club_memberships, :foreign_key => 'member_id'
  has_many :clubs,            :through => :club_memberships
end
