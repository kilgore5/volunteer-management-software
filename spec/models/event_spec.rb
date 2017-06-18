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
#  slug               :string
#
# Indexes
#
#  index_events_on_client_owner_id  (client_owner_id)
#  index_events_on_slug             (slug)
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
