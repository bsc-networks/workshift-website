class Workshift < ActiveRecord::Base
  has_many :assigned_workshifts
  has_many :users, through: :assigned_workshifts
  # attr_accessible :title, :body
end
