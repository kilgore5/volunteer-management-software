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
#  provider               :string
#  uid                    :string
#  stripe_customer_id     :string
#  deleted_at             :datetime
#
# Indexes
#
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#

class User < ApplicationRecord

  acts_as_paranoid

  # FIX_ME - this relationship is not setup properly at the minute
  # has_and_belongs_to_many :accepted_events, class_name: "Event"
  # has_and_belongs_to_many :applied_events, class_name: "Event"
  alias_attribute :applications, :apps

  has_many :apps, class_name: "Apply"

  has_one :emergency_contact
  accepts_nested_attributes_for :emergency_contact, :reject_if => :all_blank, :allow_destroy => true  

  # Enables roles for Users via the Rolify gem and CanCanCan gem
  rolify

  # Allows 'friendly' slugs
  extend FriendlyId
  friendly_id :full_name, use: :slugged  

  # Allows a shift_manager role to be in charge of a specific rotation
  has_many :rotations

  has_many :skills

  # Saves amounts charged to that person
  has_many :charges

  accepts_nested_attributes_for :skills, :reject_if => :all_blank, :allow_destroy => true  

  has_many    :volunteer_preferred_departments
  has_many    :preferred_departments, through: :volunteer_preferred_departments, source: :job_department

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  # Actions to take when saving User
  before_save :set_full_name
  after_create :assign_default_role
  after_create :add_emergency_contact

  # Model validations
  validates_presence_of :email

  # Sets the user's avatar from Paperclip gem
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
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

  def select_label
    return "#{self.full_name} (#{self.email})"
  end

  # defines information received when user signs in with Facebook link
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # Extracts the first and last name from omniauth's name
      full = auth.info.name.split
      user.first_name = full[0]
      full.delete_at(0)
      user.last_name = full * ' '

      # Sets the email, password, and avatar for the user
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.avatar = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  protected

    # Sets the user's full name on save
    def set_full_name
      unless self.first_name.nil? or self.last_name.nil?
        self.full_name = "#{self.first_name.capitalize} #{self.last_name.capitalize}"
      else
        self.full_name = "#{self.first_name} #{self.last_name}"
      end
    end

    # Assigns default role of :volunteer when user is created (Rollify gem + CanCanCan)
    def assign_default_role
      self.add_role(:volunteer) if self.roles.blank?
    end  

    # Creates an empty emergency contact for the new user
    def add_emergency_contact
      contact = EmergencyContact.create(user_id: self.id, name: "", phone_number: "", )
    end      
end
