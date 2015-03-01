class AssignedWorkshift < ActiveRecord::Base
  belongs_to :workshift
  belongs_to :user
  attr_accessible :user_id, :workshift_id
  validates :user_id, :workshift_id, presence: true
end
