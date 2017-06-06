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
  belongs_to                  :event
  has_and_belongs_to_many     :jobs
  has_many                    :rotations, through: :jobs
  has_many                    :shifts
  # Actions when saving
  after_save                  :create_rotations

  # Calculates the total shifts to be filled for the day
  def total_rotations

    shifts = 0

    self.jobs.each do |job|
      shifts += job.rotations_required_per_day
    end

    return shifts

  end  

  # Calculates the workers needed per day
  def total_workers_needed

    workers = 0

    self.jobs.each do |job|
      workers += job.rotations_required_per_day * job.workers_per_rotation
    end

    return workers

  end

  # Calculates the volunteer hours needed per day
  def total_hours_needed

    hours = 0

    self.jobs.each do |job|
      hours += (job.rotations_required_per_day * job.workers_per_rotation * job.hours_per_rotation)
    end

    return hours

  end

  private

    def create_rotations

      @jobs = self.jobs

      # Loop through jobs assigned to that day
      @jobs.each do |job|
        # Set count based on rotations
        rotation_count = job.rotations_required_per_day

        # create one rotation for each count
        i = 1
        rotation_count.times do |rotation|
          Rotation.where(job_id: job.id, day_id: self.id, count: i).first_or_create   
          i += 1
        end

        # For pry testing ONLY
        # i = 1
        # rotation_count.times do |rotation|
        #   Rotation.where(job_id: job.id, day_id: e.id, count: i).first_or_create 
        #   i += 1
        # end      

      end

    end  


end
