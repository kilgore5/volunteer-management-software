# == Schema Information
#
# Table name: events
#
#  id                         :uuid             not null, primary key
#  start_time                 :datetime
#  end_time                   :datetime
#  event_length               :float
#  ticket_price_cents         :integer
#  client_owner_id            :uuid
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  name                       :string
#  slug                       :string
#  application_closing_date   :datetime
#  initial_charge_description :string
#  initial_charge_cents       :integer
#  deleted_at                 :datetime
#  deadline_to_decline        :datetime
#  primary_contact_email      :string
#
# Indexes
#
#  index_events_on_client_owner_id  (client_owner_id)
#  index_events_on_deleted_at       (deleted_at)
#  index_events_on_slug             (slug)
#

FactoryGirl.define do
  factory :event do
    start_time "2017-05-15 18:55:20"
    end_time "2017-05-15 18:55:20"
    event_length 1.5
    ticket_price_cents 1
    user nil
  end
end
