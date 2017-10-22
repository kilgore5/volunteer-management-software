# == Schema Information
#
# Table name: applies
#
#  id                   :uuid             not null, primary key
#  event_id             :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  info                 :text
#  user_id              :uuid
#  volunteered_before   :boolean          default(FALSE), not null
#  been_before          :boolean          default(FALSE), not null
#  friends_or_referrals :text
#  terms_accepted       :boolean
#  rating               :integer          default(0)
#  deleted_at           :datetime
#  state                :string           default("submitted")
#  job_id               :uuid
#
# Indexes
#
#  index_applies_on_been_before         (been_before)
#  index_applies_on_deleted_at          (deleted_at)
#  index_applies_on_event_id            (event_id)
#  index_applies_on_user_id             (user_id)
#  index_applies_on_volunteered_before  (volunteered_before)
#

class Apply < ApplicationRecord

  self.primary_key = "id"

  # Includes State Machine Concern
  include ApplyStateMachine
  include ApplyCsvExport
  # Includes Job Assignment Concern
  # include ApplyJobAssignment

  # Doesn't allow real deletion
  acts_as_paranoid

  belongs_to  :event
  belongs_to  :user
  belongs_to  :job, optional: true
  has_many    :application_preferred_jobs
  has_many    :preferred_jobs, through: :application_preferred_jobs, source: :job
  accepts_nested_attributes_for :user, :reject_if => :all_blank, :allow_destroy => false

  validates   :terms_accepted, acceptance: true

  def before_deadline?
    event.deadline_to_decline > Time.now
  end

  def status_label
    case self.state
    when "submitted"
      status_label = "default"
    when "accepted"
      status_label = "primary"
    when "waitlisted"
      status_label = "warning"
    when "denied"
      status_label = "danger"
    when "confirmed"
      status_label = "success"
    end
  end
  # validates   :user, presence: true
  # validates_presence_of :first_name
  # validates_presence_of :last_name
  # validates_presence_of :email
  # validates_presence_of :mobile_number
  # validates_presence_of :birthday

end
