# == Schema Information
#
# Table name: application_for_events
#
#  id         :uuid             not null, primary key
#  event_id   :uuid
#  accepted   :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  info       :text
#  user_id    :uuid
#
# Indexes
#
#  index_application_for_events_on_event_id  (event_id)
#  index_application_for_events_on_user_id   (user_id)
#

class ApplicationForEvent < ApplicationRecord
  belongs_to :event
  belongs_to :user

  accepts_nested_attributes_for :user, :reject_if => :all_blank, :allow_destroy => true
end
