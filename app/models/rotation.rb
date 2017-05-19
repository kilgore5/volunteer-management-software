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
  belongs_to                :shift_manager, class_name: "User", optional: true
  belongs_to                :day, class_name: "EventDay"
  belongs_to                :job
  has_many                  :shifts
end
