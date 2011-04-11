class CompletedTitle < ActiveRecord::Base
  belongs_to :dog
  belongs_to :title
end
