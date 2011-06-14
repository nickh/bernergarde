class Person < ActiveRecord::Base
  include AnyMatcher

  has_many :dogs,             :foreign_key => 'owner_id'
  has_many :litters,          :foreign_key => 'breeder_id'
  has_many :club_memberships, :foreign_key => 'member_id'
  has_many :clubs,            :through => :club_memberships

  def full_name
    [first_name, last_name].join(' ')
  end
end
