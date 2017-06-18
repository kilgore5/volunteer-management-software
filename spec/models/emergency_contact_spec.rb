# == Schema Information
#
# Table name: emergency_contacts
#
#  id           :uuid             not null, primary key
#  user_id      :uuid
#  name         :string
#  phone_number :string
#  relationship :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_emergency_contacts_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe EmergencyContact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
