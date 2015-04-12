class WorkshiftAssignment < ActiveRecord::Base
  belongs_to :workshifter, class_name: "User", foreign_key: "workshifter_id"
  belongs_to :verifier, class_name: "User", foreign_key: "verifier_id"
  belongs_to :workshift

  attr_accessible :description, :date, :end_time, :hours, :schedule_id, :sign_off_time,
                  :start_time, :status, :task

  after_create :schedule_in_progress_status

  validates :start_time, :end_time, :date, :task, :hours,
            :description, :status, presence: true

  def assign_workshifter(user)
    self.workshifter = user
    self.save!
  end

  def check_off(verifier)
    if verifier != self.workshifter || verifer.role === 'Workshift Manager'
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

  # def localized_start_time
  #   return zoned_time(start_time)
  # end

  # def localized_end_time
  #   return zoned_time(end_time)
  # end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end

  def can_check_off? 
    self.status == "in progress" || self.status == "awaiting check off"
  end

  protected

  def schedule_in_progress_status
    begin_workshift_date = date + start_time.hour.hours
    # puts "in progress date = #{begin_workshift_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{begin_workshift_date.to_s}" do schedule_awaiting_check_off_status end
    #puts "in_progress = #{Rufus::Scheduler.singleton.job(schedule_id).time}"
  end

  def schedule_awaiting_check_off_status
    self.status = "in progress"
    end_workshift_date = date + end_time.hour.hours
    # puts "awaiting date = #{end_workshift_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{end_workshift_date.to_s}" do schedule_blown_check_up end
    # puts "schedule_awaiting = #{schedule_awaiting}"
  end

  def schedule_blown_check_up
    self.status = "awaiting check off"
    checkup_date = date + end_time.hour.hours + 48.hours
    # puts "blown time = #{checkup_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{checkup_date.to_s}" do blown_check_up end
    # puts "checkup = #{checkup}"
  end

  def blown_check_up
    if status == "awaiting check off"
      self.status = "blown"
      self.workshift.generate_next_assignment
    end
  end

end
