# == Schema Information
#
# Table name: volunteer_preferred_departments
#
#  id                :uuid             not null, primary key
#  name              :string
#  user_id           :uuid
#  job_department_id :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_volunteer_preferred_departments_on_job_department_id  (job_department_id)
#  index_volunteer_preferred_departments_on_user_id            (user_id)
#

class VolunteerPreferredDepartment < ApplicationRecord
  belongs_to      :user
  belongs_to      :job_department
end
