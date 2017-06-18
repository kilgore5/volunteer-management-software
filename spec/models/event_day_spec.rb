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

require 'rails_helper'

RSpec.describe EventDay, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
