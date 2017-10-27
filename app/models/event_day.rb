# == Schema Information
#
# Table name: event_days
#
#  id         :uuid             not null, primary key
#  event_id   :uuid
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
# Indexes
#
#  index_event_days_on_event_id  (event_id)
#  index_event_days_on_slug      (slug)
#

class EventDay < ApplicationRecord
  belongs_to                  :event
  has_and_belongs_to_many     :jobs
  has_many                    :rotations, through: :jobs
  has_many                    :shifts, dependent: :destroy
  # Actions when saving
  after_save                  :create_rotations
  before_destroy              :destroy_rotations

  # Allows 'friendly' slugs
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:date, self.event.slug]
    ]
  end

  def volunteers
    volunteer_team = []
    self.shifts.where.not(volunteer_id: nil).each do |shift|
      volunteer_team << shift.volunteer
    end
    volunteer_team
  end

  def covered_shifts
    self.shifts.where.not(volunteer_id: nil).includes(:volunteer)
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

      # if self.rotations.any?
      #   return
      # end

      @jobs = self.jobs

      # Loop through jobs assigned to that day
      @jobs.each do |job|
        # Set count based on rotations
        rotation_count = job.rotations_required_per_day

        # create one rotation for each count
        i = 1
        rotation_count.times do |rotation|

          # Calculates the hours the rotation should start after the start of the day
          hours_calc = ( i - 1 ) * job.hours_per_rotation

          Rotation.where(
            job_id:           job.id,
            day_id:           self.id,
            count:            i,
            length:           job.hours_per_rotation,
            start_time:       self.date.to_datetime + hours_calc.hours
          ).first_or_create

          i += 1
        end

      end

    end

    def destroy_rotations
      self.rotations.each {|r|r.destroy}
    end

end
