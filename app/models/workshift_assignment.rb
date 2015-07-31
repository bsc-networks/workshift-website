class WorkshiftAssignment < ActiveRecord::Base
  belongs_to :workshifter, class_name: "User", foreign_key: "workshifter_id"
  belongs_to :verifier, class_name: "User", foreign_key: "verifier_id"
  belongs_to :workshift

  attr_accessible :description, :date, :end_time, :hours, :schedule_id, :sign_off_time,
                  :start_time, :status, :task, :purchased

  after_create :schedule_in_progress_status

  validates :start_time, :end_time, :date, :task, :hours,
            :description, :status, presence: true
  before_destroy :unschedule_task

  def self.assignments_on_market
    WorkshiftAssignment.where("status = 'on market' OR status = 'on market (late)'")
  end

  def assign_workshifter(user)
    self.workshifter = user
    self.save!
  end

  def purchased?
    purchased
  end

  def hours_multiplier
    return -1 if status == 'missed'
    return 1 if status == 'complete'
    if purchased?
      return -1 if status == 'blown'
      return 0 if status == 'sold'
    else
      return -2 if status == 'blown'
      return -1 if status == 'sold'
    end
    0
  end

  def gen_next_assignment
    if workshift and workshifter == workshift.user # still assigned to workshift
      self.workshift.generate_next_assignment
    end
  end

  # Generate weekly report pull out all info
  # for loop, different cases whether it was attempted sold/sold/done

  def check_off(verifier)
    if verifier != self.workshifter || verifier.role === 'Workshift Manager'
      self.verifier = verifier
      self.status = "complete"
      self.sign_off_time = Time.zone.now # NEEDS TO BE FIXED PROBABLY
      gen_next_assignment
      self.save!
    end
  end

  def weekday
    # return unless day >= 0 && day <= 6
    Date::DAYNAMES[date.wday]
  end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end

  def can_check_off?
    status == "in progress" || status == "awaiting check off"
  end

  def can_put_on_market?
    status == "upcoming"
  end

  def late_for_market?
    seconds_diff = begin_workshift_date.to_f - Time.now.to_f
    seconds_diff < (24 * 60 * 60) # 24 hour period to sell shift without 2x penalty
  end

  def put_on_market
    self.status = late_for_market? ? "on market (late)" : "on market"
    Rufus::Scheduler.singleton.job(self.schedule_id).unschedule
    self.schedule_id = Rufus::Scheduler.singleton.at(begin_workshift_date.to_s) do off_market_check end
    self.save!
  end

  def sell_to(buyer) # when buyer clicks buy
    self.status = "sold"
    update_workshifter_hours_balance
    Rufus::Scheduler.singleton.job(self.schedule_id).unschedule
    cloned_assignment = clone_workshift
    cloned_assignment.assign_workshifter(buyer)
    cloned_assignment.save!
    self.schedule_id = Rufus::Scheduler.singleton.at "#{end_workshift_date.to_s}" do
      gen_next_assignment
    end
    self.save!
  end

  def clone_workshift
    self.workshift.workshift_assignments.create!({
        task: task,
        description: description,
        date: date,
        start_time: start_time,
        end_time: end_time,
        hours: hours,
        status: 'upcoming',
        purchased: true
    })
  end

  def can_undo_sell?
    status == 'on market' || status == 'on market (late)'
  end

  def undo_sell
    self.status = 'upcoming'
    Rufus::Scheduler.singleton.job(self.schedule_id).unschedule
    schedule_in_progress_status
    self.save!
  end

  def unschedule_task
    if self.schedule_id
      Rufus::Scheduler.singleton.job(self.schedule_id).unschedule
    end
  end

  def begin_workshift_date
    date + start_time.hour.hours
  end

  def end_workshift_date
    date + end_time.hour.hours
  end

  def end_grace_period_date
    date + end_time.hour.hours + 48.hours
  end

  def on_market?
    status == 'on market' || status == 'on market (late)'
  end

  protected

  def update_workshifter_hours_balance
    case status
    when "complete"
      if purchased?
        self.workshifter.hours_balance += self.hours
      end
    when "blown"
      self.workshifter.hours_balance -= self.hours * 2
    when "sold"
      if purchased?
        # no points lost if bought and resold
      else
        self.workshifter.hours_balance -= self.hours
      end
    when "missed"
      self.workshifter.hours_balance -= self.hours
    else
      raise 'Cannot update workshifter hours in current status.'
    end
    self.workshifter.save!
  end

  def schedule_in_progress_status
    # puts "in progress date = #{begin_workshift_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{begin_workshift_date.to_s}" do schedule_awaiting_check_off_status end
    #puts "in_progress = #{Rufus::Scheduler.singleton.job(schedule_id).time}"
    self.save!
  end

  def schedule_awaiting_check_off_status
    self.status = 'in progress'
    # puts "awaiting date = #{end_workshift_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{end_workshift_date.to_s}" do schedule_blown_check_up end
    # puts "schedule_awaiting = #{schedule_awaiting}"
    self.save!
  end

  def schedule_blown_check_up
    self.status = 'awaiting check off'
    # puts "blown time = #{checkup_date}"
    self.schedule_id = Rufus::Scheduler.singleton.at "#{end_grace_period_date.to_s}" do blown_check_up end
    # puts "checkup = #{checkup}"
    self.save!
  end

  def blown_check_up
    return unless status == 'awaiting check off'
    self.status = 'blown'
    update_workshifter_hours_balance
    gen_next_assignment
    self.save!
  end

  # triggers at beginning of workshift
  def off_market_check
    if status == 'on market'
      self.status = 'missed'
      update_workshifter_hours_balance
      gen_next_assignment
    elsif status == 'on market (late)'
      self.status = 'blown'
      update_workshifter_hours_balance
      gen_next_assignment
    end
    self.save!
  end
end
