# == Schema Information
#
# Table name: rotations
#
#  id               :uuid             not null, primary key
#  shift_manager_id :uuid
#  day_id           :uuid
#  job_id           :uuid
#  length           :integer          default(1)
#  start_time       :datetime
#  count            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_rotations_on_day_id            (day_id)
#  index_rotations_on_job_id            (job_id)
#  index_rotations_on_shift_manager_id  (shift_manager_id)
#

class Rotation < ApplicationRecord
  # Allows optional manager owner, as this will not not set when created
  belongs_to                    :shift_manager, class_name: "User", optional: true
  belongs_to                    :day, class_name: "EventDay"
  belongs_to                    :job
  has_many                      :shifts, dependent: :destroy
  accepts_nested_attributes_for :shifts, :shift_manager, :reject_if => :all_blank, :allow_destroy => true

  # Actions when saving
  after_create                  :create_shifts

  # calculate the shifts in this rotation instance
  def total_shifts
    self.shifts.count
  end

  # calculate the shifts covered in this rotation instance
  def covered_shifts
    self.shifts.where.not(volunteer_id: nil).count
  end

  # Calculate precentage of shits covered for a given rotation
  def covered_percent
    self.covered_shifts.to_f / self.total_shifts
  end

  # calculate the shifts remaining to be covered in this rotation instance
  def remaining_shifts
    self.total_shifts - self.covered_shifts
  end

  private

    def create_shifts

      @rotation = self

      shift_count = @rotation.job.workers_per_rotation

      # create one rotation for each count
      i = 1
      shift_count.times do |rotation|
        Shift.where(rotation_id: @rotation.id,
                    count: i,
                    event_day_id: @rotation.day.id,
                    job_id: @rotation.job.id,
                    start_time: @rotation.start_time
        ).first_or_create do |shift|
          shift.length = @rotation.job.hours_per_rotation
        end
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
