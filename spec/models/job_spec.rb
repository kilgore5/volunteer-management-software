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

require 'rails_helper'

RSpec.describe Job, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
