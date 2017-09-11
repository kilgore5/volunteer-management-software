# == Schema Information
#
# Table name: charges
#
#  id              :uuid             not null, primary key
#  event_id        :uuid
#  user_id         :uuid
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("AUD"), not null
#  description     :string
#  stripe_id       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_charges_on_event_id  (event_id)
#  index_charges_on_user_id   (user_id)
#

class Charge < ApplicationRecord
  monetize :amount_cents

  belongs_to :event
  belongs_to :user
end
