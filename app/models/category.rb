class Category < ActiveRecord::Base
  belongs_to :unit
  has_many :workshifts
  has_many :preferences

  attr_accessible :name, :unit

  validates :name, presence: true
end
