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

class ApplicationForEvent < ApplicationRecord
  belongs_to  :event
  belongs_to  :user
  has_many    :application_preferred_jobs
  has_many    :preferred_jobs, through: :application_preferred_jobs, source: :job

  validates   :terms_accepted, acceptance: true

  accepts_nested_attributes_for :user, :reject_if => :all_blank, :allow_destroy => true
end
