# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# admin = User.where(:email => 'admin@admin.com').any?
puts "\n\n\n"
puts "> Admin user seed:"
if (!User.where(:email => 'admin@admin.com').any?)
	puts ">> Not found Admin User, creating a new one..."
	admin = User.create(
					:email => 'admin@admin.com',
					:password => '123456',
					:password_confirmation => '123456',
					:admin => true,
				)
	puts ">>> Done!"
else
	puts ">> Already exist an Admin User, skipping seed."
end
puts "\n\n\n"