class Unit < ActiveRecord::Base
   attr_accessible :name

   has_many :users
   has_many :workshifts
   has_many :workshift_assignments
   has_many :categories
   has_many :weekly_reports

   validates :name, presence: true
end
