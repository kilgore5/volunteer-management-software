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
#  name               :string
#
# Indexes
#
#  index_events_on_client_owner_id  (client_owner_id)
#

class Event < ApplicationRecord
  belongs_to :client_owner, class_name: "User"
  validates_presence_of :name, :start_time, :end_time, :ticket_price_cents
  before_save :set_event_length

  private

  # Sets the length of the event based on the start and end times
  def set_event_length
    # Get event length in seconds, convert to hours
    self.event_length = (self.end_time - self.start_time)/(60*60)
  end

end
