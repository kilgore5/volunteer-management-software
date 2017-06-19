# == Schema Information
#
# Table name: job_departments
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JobDepartment < ApplicationRecord
  # has_many            :volunteers
  # has_many            :jobs
  has_many            :volunteer_preferred_departments
  has_many            :volunteers, through: :volunteer_preferred_departments, source: :user  
end
