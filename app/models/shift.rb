# == Schema Information
#
# Table name: shifts
#
#  id           :uuid             not null, primary key
#  rotation_id  :uuid
#  volunteer_id :uuid
#  length       :integer          default(1)
#  count        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  event_day_id :uuid
#  job_id       :uuid
#  start_time   :datetime
#
# Indexes
#
#  index_shifts_on_event_day_id  (event_day_id)
#  index_shifts_on_job_id        (job_id)
#  index_shifts_on_rotation_id   (rotation_id)
#  index_shifts_on_volunteer_id  (volunteer_id)
#

class Shift < ApplicationRecord

  belongs_to :rotation
  belongs_to :event_day
  belongs_to :job

  # Allows optional volunteer owner, as this will not not set when created
  belongs_to :volunteer, class_name: 'User', foreign_key: 'volunteer_id', optional: true
  # has_one    :shift_rating  
end
