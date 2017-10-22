# == Schema Information
#
# Table name: jobs
#
#  id                         :uuid             not null, primary key
#  title                      :string
#  description                :text
#  event_id                   :uuid
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  workers_per_rotation       :integer          default(0)
#  hours_per_rotation         :integer          default(0)
#  rotations_required_per_day :integer          default(0)
#  slug                       :string
#  meeting_place              :string           default("The Volunteer Tent")
#
# Indexes
#
#  index_jobs_on_event_id  (event_id)
#  index_jobs_on_slug      (slug)
#

class Job < ApplicationRecord
  belongs_to                    :event
  has_and_belongs_to_many       :days, class_name: "EventDay"
  has_many                      :rotations, dependent: :destroy
  has_many                      :skill_requirements, dependent: :destroy
  accepts_nested_attributes_for :skill_requirements, :reject_if => :all_blank, :allow_destroy => true
  has_many                      :application_preferred_jobs
  has_many                      :applications, through: :application_preferred_jobs, source: :apply

  # Allows 'friendly' slugs
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged  
  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      [:title, self.event.slug]
    ]
  end

  # Create validations for the model
  validates_presence_of :title, :description, :event_id

  def total_shifts(day)
    #TODO - need to get the total shifts for that particular day for that job, not all shifts for that job
    # @job = Job.where()
    6
  end

  def total_rotations_by_day(job, day)

    rotations = Rotation.where(job_id: job.id, day_id: day.id)

    

    total = 0

    rotations.each do |rotation|
      total += rotation.shifts.count
    end

    return total

  end  


end
