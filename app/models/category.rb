class Category < ActiveRecord::Base
  has_many :workshifts

  attr_accessible :name

  validates :name, presence: true

end
