# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

super_admin = User.new( first_name: 'Super', last_name: 'Admin', email: ENV['gmail_username'], password: ENV['super_admin_pass'] )
super_admin.skip_confirmation!
super_admin.add_role :admin
super_admin.save
