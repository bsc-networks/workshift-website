class Preference < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  attr_accessible :rank, :user_id, :category_id
end
