class ClubMembership < ActiveRecord::Base
  belongs_to :club
  belongs_to :member, :class_name => 'Person'
end
