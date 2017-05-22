# == Schema Information
#
# Table name: shifts
#
#  id           :uuid             not null, primary key
#  rotation_id  :uuid
#  volunteer_id :uuid
#  length       :integer          default(1)
#  start_time   :integer
#  count        :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_shifts_on_rotation_id   (rotation_id)
#  index_shifts_on_volunteer_id  (volunteer_id)
#

class Shift < ApplicationRecord

  belongs_to :rotation

  # Allows optional volunteer owner, as this will not not set when created
  belongs_to :volunteer, class_name: 'User', optional: true
  # has_one    :shift_rating  
end
