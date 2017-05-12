json.extract! user, :id, :first_name, :last_name, :full_name, :email, :birthday, :mobile_number, :slug, :shifts_made, :shifts_missed, :apps_accepted, :hours_worked, :rating, :created_at, :updated_at
json.url user_url(user, format: :json)
