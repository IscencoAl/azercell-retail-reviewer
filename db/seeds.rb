# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create user roles
UserRole.create(:name => 'admin')
UserRole.create(:name => 'user')

# Create user
User.create(:name => 'Admin', :surname => 'Magnetsoft', :email => 'admin@magnetsoft.md',
  :password => 'admin@magnetsoft.md', :role => UserRole.admin)