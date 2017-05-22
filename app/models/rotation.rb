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
  belongs_to                  :shift_manager, class_name: "User", optional: true
  belongs_to                  :day, class_name: "EventDay"
  belongs_to                  :job
  has_many                    :shifts

  # Actions when saving
  after_save                  :create_shifts

  # calculate the shifts in this rotation instance
  def total_shifts
    self.shifts.count
  end

  private

    def create_shifts

      @rotation = self

      shift_count = @rotation.job.workers_per_rotation

      # create one rotation for each count
      i = 1
      shift_count.times do |rotation|
        Shift.where(rotation_id: @rotation.id, count: i).first_or_create do |shift|
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
