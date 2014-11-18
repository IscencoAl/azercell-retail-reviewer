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
UserRole.create(:name => 'reviewer')
UserRole.create(:name => 'dealer')

# Create report element types
ReportStructureElementType.create(:name => 'mark')
ReportStructureElementType.create(:name => 'check')
ReportStructureElementType.create(:name => 'input')

# Create API settings
ApiSetting.create(:name => 'app_version', :value => '1')
ApiSetting.create(:name => 'shops_structure_version', :value => '1')
ApiSetting.create(:name => 'report_structure_version', :value => '1')
ApiSetting.create(:name => 'server_path', :value => '/Users/sergheycebotari/Work/azercell-retail-reviewer/public/')

# Create user
# User.create(:name => 'Admin', :surname => 'Magnetsoft', :email => 'admin@magnetsoft.md', :password => 'admin@magnetsoft.md', :password_confirmation => 'admin@magnetsoft.md', :role => UserRole.admin)