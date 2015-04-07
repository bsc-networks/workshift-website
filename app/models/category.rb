class Category < ActiveRecord::Base
  has_many :workshifts
  has_many :preferences

  attr_accessible :name

  validates :name, presence: true
end
