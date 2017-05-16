# == Schema Information
#
# Table name: event_days
#
#  id         :uuid             not null, primary key
#  event_id   :uuid
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_event_days_on_event_id  (event_id)
#

class EventDay < ApplicationRecord
  belongs_to :event
end
