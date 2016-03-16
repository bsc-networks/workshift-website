class Shift < ActiveRecord::Base
  belongs_to :metashift
  belongs_to :user
end
