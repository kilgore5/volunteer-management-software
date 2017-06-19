# == Schema Information
#
# Table name: skills
#
#  id                          :uuid             not null, primary key
#  name                        :string
#  user_id                     :uuid
#  proof_document_file_name    :string
#  proof_document_content_type :string
#  proof_document_file_size    :integer
#  proof_document_updated_at   :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#
# Indexes
#
#  index_skills_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :skill do
    name "MyString"
    user nil
    proof_document ""
  end
end
