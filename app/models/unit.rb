class Unit < ActiveRecord::Base
    has_one :policy
    has_many :users
end
