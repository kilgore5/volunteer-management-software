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

FactoryGirl.define do
  factory :event_day do
    event nil
  end
end
