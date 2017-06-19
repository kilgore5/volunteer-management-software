# == Schema Information
#
# Table name: application_for_events
#
#  id                   :uuid             not null, primary key
#  event_id             :uuid
#  accepted             :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  info                 :text
#  user_id              :uuid
#  volunteered_before   :boolean          default(FALSE), not null
#  been_before          :boolean          default(FALSE), not null
#  friends_or_referrals :text
#  terms_accepted       :boolean
#
# Indexes
#
#  index_application_for_events_on_been_before         (been_before)
#  index_application_for_events_on_event_id            (event_id)
#  index_application_for_events_on_user_id             (user_id)
#  index_application_for_events_on_volunteered_before  (volunteered_before)
#

FactoryGirl.define do
  factory :application_for_event do
    event nil
    user nil
    accepted false
  end
end
