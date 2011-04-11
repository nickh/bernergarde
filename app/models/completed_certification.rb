class CompletedCertification < ActiveRecord::Base
  belongs_to :certification
  belongs_to :dog
end
