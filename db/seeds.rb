# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


10.times do |i|
  User.create!(
    id: "#{i+6}",
    name: "test#{i+6}",
    email: "test#{i+6}@test.com",
    password_digest: "test#{i+6}",
    area: "tokyo",
    age: "#{i+6}"
  )
end