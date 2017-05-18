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
  belongs_to              :client_owner, class_name: "User"
  has_many                :event_days
  has_many                :accepted_volunteers, class_name: "User"
  has_many                :applied_volunteers, class_name: "User"
  has_many                :applications, class_name: "ApplicationForEvent"

  # Allows nested forms to add jobs for an event
  has_many                :jobs
  accepts_nested_attributes_for :jobs, :reject_if => :all_blank, :allow_destroy => true
  validates_presence_of   :name, :start_time, :end_time, :ticket_price_cents
  before_create             :set_event_length
  after_create              :create_event_days

  private

  # Sets the length of the event based on the start and end times
  def set_event_length
    # Get event length in seconds, convert to hours
    self.event_length = (self.end_time - self.start_time)/(60*60)
  end

  # Creates days for each event, that can be used for scheduling
  def create_event_days
    @days = []
    first = self.start_time.to_date
    last = self.end_time.to_date
    duration = (last-first).to_i

    i = 0

    # Adds each day of event into the days array
    until i >= duration do
      @days << (first + i.days)
      i += 1
    end

    @days.each do |day|
      EventDay.create!(event_id: self.id, date: day)
    end

  end

end
