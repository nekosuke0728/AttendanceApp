# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

Admin.find_or_create_by(id: 1) do |admin|
 admin.email = 'admin@sample.com'
 admin.password = 'password'
end

10.times do |u|
 User.create!(
   email: "user#{u + 1}@sample.com",
   password: "password",
   name: "user#{u + 1}",
   birthday: 20000101,
   gender: 0,
   employment_status: 0,
   address: "日本",
   phone: "09000000000",
   )
end
