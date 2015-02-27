class AssignedWorkshift < ActiveRecord::Base
  belongs_to :workshift
  belongs_to :user
  # attr_accessible :title, :body
end
