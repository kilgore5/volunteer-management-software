# == Schema Information
#
# Table name: events
#
#  id                 :uuid             not null, primary key
#  start_time         :datetime
#  end_time           :datetime
#  event_length       :float
#  ticket_price_cents :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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
