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

class Skill < ApplicationRecord
  belongs_to :user

  # Uses Paperclip gem to allow the Skill to have a proof_document
  has_attached_file :proof_document, styles: { thumb: "100x100>" }, default_url: "missing.png"
  # Validates that the document is a real image when uploaded
  validates_attachment_content_type :proof_document, content_type: /\Aimage\/.*\z/  
  # Process proof_document as a background job, to not slow the user creation process.  delayed_paperclip gem
  process_in_background :proof_document 

end
