# == Schema Information
#
# Table name: workshifts
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  start_time    :time
#  end_time      :time
#  day           :integer
#  people_needed :integer
#  description   :text
#  task          :string(255)
#  hours         :integer
#
class Workshift < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :workshift_assignments
  attr_accessible :start_time, :end_time, :day, :task, :category_id
                  :description, :hours
  before_save :apply_time_zone
  validates :start_time, :end_time, :day, :task,
            :description, presence: true
  validates :day, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 6 }
  validate :end_time_later_than_start_time

  
  # def assignworkers(assigned_user_ids, workshiftid)
  #   thisWorkshift = Workshift.find(workshiftid)
  #   thisWorkshift.assigned_workshifts.destroy_all
  #   assigned_user_ids.each do |a|
  #     if not already_assigned_user(a)
  #       assign = AssignedWorkshift.create({"user_id" => a, "workshift_id" => workshiftid})
  #       assignUser = User.find(a)
  #     end
  #   end
  # end

  def assign_worker(uid)
    worker = User.find_by_id(uid)
    if worker != self.user
      self.user = worker
      # to delete or not to delete old user's current assignment
      # generate new assignment for new user immediately
      generate_next_assignment
      self.save!
    end
  end

  def generate_next_assignment
    #Time.zone = "Pacific Time (US & Canada)"
    Chronic.time_class = Time.zone
    assignment_date = Chronic.parse "next #{self.weekday} at midnight"
    assignment = self.workshift_assignments.create!({
        task: self.task,
        description: self.description,
        date: assignment_date,
        start_time: start_time,
        end_time: end_time,
        hours: self.hours,
        status: "upcoming",
    })
    assignment.assign_workshifter(self.user)
    puts "start time = #{start_time}"
    puts "end time = #{end_time}"
    puts end_time.hour
    puts assignment_date
    puts assignment_date + end_time.hour.hours
    puts assignment_date + end_time.hour.hours + end_time.min.minutes
    #Rufus::Scheduler.singleton.at "#{assignment_date}"
    assignment.save!
  end

  def end_time_later_than_start_time
    return if end_time > start_time
    errors.add(:end_time, 'must be later than the starting time.')
  end

  def self.valid_days
    days = []
    7.times do |i|
      days << [Date::DAYNAMES[i], i]
    end
    days
  end

  def self.create_assignments
    Workshift.all.each do |workshift|
      logger.info "Creating assignment for workshift #{workshift.task}"
    end
  end

  def weekday
    # return unless day >= 0 && day <= 6
    Date::DAYNAMES[day]
  end

  def category_name
    return category.name unless category.nil?
    "Uncategorized"
  end

  def formatted_start_time
    start_time.strftime('%l:%M %p')
  end

  def formatted_end_time
    end_time.strftime('%l:%M %p')
  end

  protected

  def apply_time_zone
    puts "orig start time = #{start_time}"
    puts "orig end time = #{end_time}"
    puts "time zone = #{Time.zone.now}"
    utc_offset = Time.zone.now.utc_offset
    self.start_time = start_time - utc_offset.seconds
    self.end_time = end_time - utc_offset.seconds
    puts "after start time = #{start_time}"
    puts "after end time = #{end_time}"
  end
end
