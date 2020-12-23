# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Profile.delete_all
User.delete_all

Profile.create!(
  domain: "localhost",
  from: "quotes@example.com",
  html: "<!DOCTYPE html>",
  intro: "Hello!",
  name: "Demo",
  subject: "Demo quote",
)

User.create!(
  admin: true,
  email: "admin@example.com",
  name: "Admin",
  password: "topsecret",
)
