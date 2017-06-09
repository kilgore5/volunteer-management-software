# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creates the "super admin character"
super_admin = User.new( first_name: 'Super', last_name: 'Admin', email: ENV['gmail_username'], password: ENV['super_admin_pass'] )
super_admin.skip_confirmation!
super_admin.add_role :admin
super_admin.save


# Only if development
if Rails.env == "development"

  Event.all.each { |e| e.delete}

  # Creates an example event_client
  client = User.new( first_name: 'Event', last_name: 'Client', email: "test@client.com", password: "password" )
  client.skip_confirmation!
  client.add_role :event_client
  client.save

  # Creates some example volunteers
  vol = User.new( first_name: 'Joe', last_name: 'Volunteer', email: "joe@volunteer.com", password: "password" )
  vol.skip_confirmation!
  vol.add_role :volunteer
  vol.save  
  vol2 = User.new( first_name: 'Simon', last_name: 'Volunteer', email: "simon@volunteer.com", password: "password" )
  vol2.skip_confirmation!
  vol2.add_role :volunteer
  vol2.save
  vol2 = User.new( first_name: 'Tom', last_name: 'Volunteer', email: "tom@volunteer.com", password: "password" )
  vol2.skip_confirmation!
  vol2.add_role :volunteer
  vol2.save  

  # Creates an example event
  event = Event.create!(
    :name => "Strawberry Fields",
    :start_time => DateTime.now + 30.days,
    :end_time => DateTime.now + 33.days,        
    :ticket_price_cents => 3000,
    :client_owner => client
  )

  # Creates jobs for the event
  job1 = Job.create!(
    :title => "Cleaning Toilets",      
    :description => "Gross Job, but short shift times.  'Inner workings' of the festival exposed...", 
    :event => event
  )
  job2 = Job.create!(
    :title => "Rubbish Pickup",      
    :description => "Perhaps in between sets, perhaps at campsite, perhaps post festival", 
    :event => event
  )  
  job = Job.create!(
    :title => "Taking artists to accom",      
    :description => "We'll provide the vehicle.  Need to be comfortable with staying sober on the day of your shift in order to drive.",
    :event => event
  )

  #Creates skill_requirements for one of the jobs
  req = SkillRequirement.create!(
    :title => "Driver's License",      
    :description => "Necessary, no negotiations.  Must be Australian / permitted to drive in Australia",
    :job => job
  )      

  #Creates a skill for one of the volunteers
  skill = Skill.create!(
    :name => "Driver's License",      
    # :description => "Necessary, no negotiations.  Must be Australian / permitted to drive in Australia",
    :user => vol
  )    

end
