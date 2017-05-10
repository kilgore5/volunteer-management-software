# Pseudo-code for model planning

class User < ApplicationRecord

  has_many :roles
  has_many :events
  has_many :shifts, through: :events

end
 
class Shift < ApplicationRecord

  belongs_to :event
  belongs_to :volunteer, class_name: 'User'

end
 
class Event < ApplicationRecord

  has_many :shifts
  has_many :users, through: :shifts
  
end