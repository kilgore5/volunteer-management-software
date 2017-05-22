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
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#

class User < ApplicationRecord

  # Enables roles for Users via the Rolify gem and CanCanCan gem
  rolify

  has_and_belongs_to_many :accepted_events, class_name: "Event"
  has_and_belongs_to_many :applied_events, class_name: "Event"

  has_many :applications, class_name: "ApplicationForEvent"

  # Allows a shift_manager role to be in charge of a specific rotation
  has_many :rotations

  has_many :skills
  accepts_nested_attributes_for :skills, :reject_if => :all_blank, :allow_destroy => true  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Actions to take when saving User
  before_create :set_full_name
  after_create :assign_default_role

  # Model validations
  validates_presence_of :email

  # Sets the user's avatar from Paperclip gem
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # Validates that the avatar is a real image when uploaded
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  # Process the avatar as a background job, to not slow the user creation process.  delayed_paperclip gem
  process_in_background :avatar


  # send Devise emails through your existing queue by overriding the 
  # send_devise_notification method in your model
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def age
    if self.birthday?
      dob = self.birthday
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    else
      "-"
    end

  end

  protected

    # Sets the user's full name on save
    def set_full_name
      self.full_name = "#{self.first_name} #{self.last_name}"
    end

    # Assigns default role of :volunteer when user is created (Rollify gem + CanCanCan)
    def assign_default_role
      self.add_role(:volunteer) if self.roles.blank?
    end  
end
