# == Schema Information
#
# Table name: application_for_events
#
#  id           :uuid             not null, primary key
#  event_id     :uuid
#  volunteer_id :uuid
#  accepted     :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  info         :text
#
# Indexes
#
#  index_application_for_events_on_event_id      (event_id)
#  index_application_for_events_on_volunteer_id  (volunteer_id)
#

class ApplicationForEvent < ApplicationRecord
  belongs_to :event
  belongs_to :volunteer, class_name: "User"

  accepts_nested_attributes_for :volunteer
end
