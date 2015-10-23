# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(first_name: 'Sang', last_name: 'Yu', 
	email: 'yu@unimelb.edu.au', bio: 'Some really awesome author that wrote some stuff',
	username: 'yusang', password: 'aaa', password_confirmation: 'aaa', subscribed: 'true', tag_list: 'afl')

s = Source.create!(name: 'SBS')
s2 = Source.create!(name: 'TheAge')
s3 = Source.create!(name: 'TheABC')
s4 = Source.create!(name: 'The Herald Sun')
s5 = Source.create!(name: 'The Sydney Morning Herald')
s6 = Source.create!(name: 'The New York Times')