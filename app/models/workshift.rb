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
  attr_accessible :start_time, :end_time, :day, :task, :people_needed,
                  :description, :hours, :category_id

  validates :start_time, :end_time, :day, :task,
            :description, presence: true
  validates :day, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 6 }
  validate :end_time_later_than_start_time

  
  def assignworkers(workerid, workshiftid)
    if num_assigned < people_needed and already_assigned_user(workerid[0]) == false
      assign = AssignedWorkshift.create({"user_id" => workerid[0], "workshift_id" => workshiftid[0]})
      assignUser = User.find(workerid[0])
      if assignUser.assigned_workshifts.nil?
        assignUser.assigned_workshifts = Array.new
      end
      assignUser.assigned_workshifts.nil?
      assignUser.assigned_workshifts << assign
      if @assigned_workshifts.nil?
        @assigned_workshifts = Array.new
      end
      @assigned_workshifts << assign
    end


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

  def num_assigned
    users.length
  end

  def assigned_so_far
    "#{num_assigned}/#{people_needed}"
  end

  def already_assigned_user(userid)
    b = false
    user = User.find(userid)
    usershifts = user.assigned_workshifts
    usershifts.each do |u|
      if u.workshift_id == id
        b = true
      end
    end
    b
  end

  def assignedworkers
    names = ""
    relation = users.select(:name).all
    relation.each do |r|
      names = names + r.name + ", "
    end
    names[0..-3]
  end
end
