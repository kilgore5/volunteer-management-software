# == Schema Information
#
# Table name: jobs
#
#  id          :uuid             not null, primary key
#  title       :string
#  description :text
#  event_id    :uuid
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_jobs_on_event_id  (event_id)
#

class Job < ApplicationRecord
  belongs_to :event
  # has_many   :shifts
  has_many   :skill_requirements
  accepts_nested_attributes_for :skill_requirements, :reject_if => :all_blank, :allow_destroy => true

  # Create validations for the model
  validates_presence_of :title, :description, :event_id
end
