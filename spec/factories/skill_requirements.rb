# == Schema Information
#
# Table name: skill_requirements
#
#  id          :uuid             not null, primary key
#  job_id      :uuid
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_skill_requirements_on_job_id  (job_id)
#

FactoryGirl.define do
  factory :skill_requirement do
    job nil
    title "MyString"
    description "MyText"
  end
end
