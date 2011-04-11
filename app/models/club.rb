class Club < ActiveRecord::Base
  has_many :club_memberships
  has_many :members, :through => :club_memberships, :class_name => 'Person'
end
