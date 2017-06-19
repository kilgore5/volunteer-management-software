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

FactoryGirl.define do
  factory :rotation do
    shift_manager nil
    day nil
    length 1
  end
end
