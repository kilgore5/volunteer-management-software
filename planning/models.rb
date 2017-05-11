# Pseudo-code for model planning

class User < ApplicationRecord

  # stripe_account    :string
  # stripe_token      :string
  # avatar            :paperclip_image
  # birthday          :datetime
  # mobile_number     :string
  # email             :string
  # shifts_made       :integer
  # shifts_missed     :integer
  # apps_accepted     :integer
  # hours_worked      :float   
  # rating            :float 


  has_many :roles
  has_many :events
  has_many :skills
  has_many :event_interests, class_name: 'Event'
  has_many :shifts, through: :events
  has_many :volunteer_applications
  has_many :volunteer_contracts
  has_many :shift_ratings
  has_one  :emergency_contact

  ## Notes

  # Should be able to be created via Facebook
  # Should be invitable
  # Has roles: volunteer, admin, event_client, shift_manager
    # admin can see all events, all users
    # volunteer can see thir information
    # event_client can see their own event's jobs, shifts, users
    # shift_manager can see their shifts, can complete shifts, and can rate volunteers
    # rolify gem with devise -- https://github.com/RolifyCommunity/rolify

    # admin will initially use administrate gem
  # Should be exportable to CSV
  # Should be able to be ranked

end
 
class Job < ApplicationRecord

  # title             :string
  # description       :text


  belongs_to :event
  has_many   :shifts
  has_many   :skill_requirements

end

class SkillRequirement < ApplicationRecord

  # title             :string
  # description       :text


  belongs_to :job

end

class Skill < ApplicationRecord

  # skill_name        :string
  # proof_document    :paperclip


  belongs_to :volunteer, class_name: 'User'

end

class Shift < ApplicationRecord

  # start_time        :datetime
  # end_time          :datetime
  # fulfilled         :boolean
  # volunteer_liable  :boolean
  # shift_length      :float

  belongs_to :event
  belongs_to :job
  belongs_to :event_day
  belongs_to :volunteer, class_name: 'User'
  has_one    :shift_rating

  ## Notes

  # If not fulfilled, within 1 week, User card should be charged
    # Only if 'liable' is true, i.e. it is their fault they missed the shift

end

class ShiftRating < ApplicationRecord

  # value        :integer, 0 - 5, default 3

  belongs_to :shift
  belongs_to :shift_manager, class_name: 'User', foreign_key: 'shift_manager_id'
  belongs_to :volunteer, class_name: 'User', foreign_key: 'volunteer_id'

  ## Notes

  # If shift not completed, should automatically be 0

end

class EmergencyContact < ApplicationRecord

  # first_name        :string
  # last_name         :string
  # email             :string
  # phone             :string
  # relationship      :string

  belongs_to :volunteer, class_name: 'User'

  ## Notes

end

class VolunteerApplication < ApplicationRecord

  # approved          :boolean, default: false
  # completed         :boolean

  belongs_to :event
  belongs_to :volunteer, class_name: 'User'


  ## Notes

  # Should be auto-filled from user profile

end

class VolunteerContract < ApplicationRecord

  # accepted          :boolean, default: false

  belongs_to :event
  belongs_to :volunteer, class_name: 'User'


  ## Notes


end
 
class Event < ApplicationRecord

  # start_time        :datetime
  # end_time          :datetime
  # event_length      :float
  # ticket_price      :money

  has_many    :shifts, through: :event_days # Unsure of this - should it just have_many jobs, which have shifts?
  # or even has many days, which has jobs, and shifts in turn?
  has_many    :jobs
  has_many    :users, through: :shifts
  has_many    :volunteer_applications
  has_many    :volunteer_contracts
  has_many    :event_days
  belongs_to  :event_client, class_name: 'User'

  ## Indexes

  add_index :events, :volunteer, class_name: 'User'

  ## Notes 

  # => The calendaring functionality will get pretty complex. 
    # => Thoughts - when creating event, pick initial volunteer day, and all volunteer days needed, off of a simple calendar

end

class EventDay < ApplicationRecord

  # accepted          :boolean, default: false

  belongs_to  :event
  has_many    :jobs, through: :event
  has_many    :shifts


  ## Notes


  # =>  Day starts at 12:00 AM  -> 11.59 PM

end