# == Schema Information
#
# Table name: events
#
#  id                 :uuid             not null, primary key
#  start_time         :datetime
#  end_time           :datetime
#  event_length       :float
#  ticket_price_cents :integer
#  client_owner_id    :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_events_on_client_owner_id  (client_owner_id)
#

class Event < ApplicationRecord
  belongs_to :client_owner, class_name: "User"
end
