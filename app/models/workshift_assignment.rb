class WorkshiftAssignment < ActiveRecord::Base
  belongs_to :workshifter, class_name: "User", foreign_key: "workshifter_id"
  belongs_to :verifier, class_name: "User", foreign_key: "verifier_id"
  belongs_to :workshift

  attr_accessible :description, :date, :end_time, :hours, :notes, :sign_off_time,
                  :start_time, :status, :task

  validates :start_time, :end_time, :date, :task, :hours,
            :description, :status, presence: true

  def assign_workshifter(user)
    self.workshifter = user
    self.save!
  end

  def check_off(verifier)
    if verifier != self.workshifter
      self.verifier = verifier
      self.status = "Completed"
      self.sign_off_time = Time.zone.now # NEEDS TO BE FIXED PROBABLY
      self.workshift.generate_next_assignment
      self.save!
    end
  end

  def weekday
    # return unless day >= 0 && day <= 6
    Date::DAYNAMES[date.wday]
  end

  def localized_start_time
    return zoned_time(start_time)
  end

  def localized_end_time
    return zoned_time(end_time)
  end

  def formatted_localized_start_time
    localized_start_time.strftime('%l:%M %p')
  end

  def formatted_localized_end_time
    localized_end_time.strftime('%l:%M %p')
  end

  protected

  def zoned_time(utc_time)
    utc_time += utc_offset
    return Chronic.parse "#{utc_time.hour}:#{utc_time.min}"
  end

  def utc_offset
    return Time.zone.now.utc_offset.seconds
  end
end
