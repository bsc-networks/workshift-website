class WorkshiftAssignment < ActiveRecord::Base
  belongs_to :workshifter, class_name: "User", foreign_key: "workshifter_id"
  belongs_to :verifier, class_name: "User", foreign_key: "verifier_id"
  belongs_to :workshift

  attr_accessible :description, :date, :end_time, :hours, :notes, :sign_off_time,
                  :start_time, :status, :task

  validates :start_time, :end_time, :date, :task, :hours,
            :description, :status, presence: true
end
