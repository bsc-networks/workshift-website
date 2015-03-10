# == Schema Information
#
# Table name: assigned_workshifts
#
#  id           :integer          not null, primary key
#  workshift_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean          default(FALSE)
#
class AssignedWorkshift < ActiveRecord::Base
  belongs_to :workshift
  belongs_to :user
  attr_accessible :user_id, :workshift_id
  validates :user_id, :workshift_id, presence: true
  validates :user_id, :workshift_id, numericality: { only_integer: true,
                                                     greater_than: 0 }
end
