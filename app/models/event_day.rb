# == Schema Information
#
# Table name: event_days
#
#  id         :uuid             not null, primary key
#  event_id   :uuid
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_days_on_event_id  (event_id)
#

class EventDay < ApplicationRecord
  belongs_to  :event
  has_and_belongs_to_many    :jobs



  # Calculates the total shifts to be filled for the day
  def total_shifts

    shifts = 0

    self.jobs.each do |job|
      shifts += job.shifts_required_per_day
    end

    return shifts

  end  

  # Calculates the workers needed per day
  def total_workers_needed

    workers = 0

    self.jobs.each do |job|
      workers += job.shifts_required_per_day * job.workers_per_shift
    end

    return workers

  end

  # Calculates the volunteer hours needed per day
  def total_hours_needed

    hours = 0

    self.jobs.each do |job|
      hours += (job.shifts_required_per_day * job.workers_per_shift * job.hours_per_shift)
    end

    return hours

  end


end
