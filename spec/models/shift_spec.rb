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

require 'rails_helper'

RSpec.describe Shift, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
