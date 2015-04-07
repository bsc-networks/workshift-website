class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :rank, presence: true

  attr_accessible :rank, :user_id, :category_id
end
