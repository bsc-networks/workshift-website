class Unit < ActiveRecord::Base
   attr_accessible :name, :quiet_hour

   has_many :users
   has_many :workshifts
   has_many :workshift_assignments
   has_many :categories
   has_many :weekly_reports
   has_one :quiet_hour

   validates :name, presence: true
end
