# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  first_name             :string
#  last_name              :string
#  full_name              :string
#  birthday               :date
#  mobile_number          :string
#  slug                   :string
#  shifts_made            :integer          default(0)
#  shifts_missed          :integer          default(0)
#  apps_accepted          :integer          default(0)
#  hours_worked           :integer          default(0)
#  rating                 :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  medical_conditions     :text
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#

FactoryGirl.define do
  factory :user do
    first_name "First"
    last_name "Last"
    email "random_email@this.anything"
    password "sdakfh;oahfh4rp94r9uj43qiqfhp"
  end
end
