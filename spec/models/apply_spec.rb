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
#
# Indexes
#
#  index_applies_on_been_before         (been_before)
#  index_applies_on_deleted_at          (deleted_at)
#  index_applies_on_event_id            (event_id)
#  index_applies_on_user_id             (user_id)
#  index_applies_on_volunteered_before  (volunteered_before)
#

require 'rails_helper'

RSpec.describe Apply, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
