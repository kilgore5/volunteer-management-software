# == Schema Information
#
# Table name: application_preferred_jobs
#
#  id         :uuid             not null, primary key
#  job_id     :uuid
#  apply_id   :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_application_preferred_jobs_on_apply_id  (apply_id)
#  index_application_preferred_jobs_on_job_id    (job_id)
#

class ApplicationPreferredJob < ApplicationRecord
  # belongs_to :application, class_name: "Apply"
  # belongs_to :preferred_role, class_name: "Role"
  belongs_to :apply
  belongs_to :job
end
