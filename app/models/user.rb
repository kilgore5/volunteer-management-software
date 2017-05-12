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
#  shifts_made            :integer          default("0")
#  shifts_missed          :integer          default("0")
#  apps_accepted          :integer          default("0")
#  hours_worked           :integer          default("0")
#  rating                 :float
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
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
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Actions to take when saving User
  before_save :set_full_name

  # Model validations
  validates_presence_of :password, :email

  # Sets the user's avatar from Paperclip gem
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # Validates that the avatar is a real image when uploaded
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # Process the avatar as a background job, to not slow the user creation process.  delayed_paperclip gem
  process_in_background :avatar

  protected

    # Sets the user's full name on save
    def set_full_name
      self.full_name = "#{self.first_name} #{self.last_name}"
    end
end
