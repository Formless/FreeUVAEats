require 'rubygems'
require 'chronic'

myfile = File.open("tmp/foo.log", "r")

e_from = myfile.readline
e_subject = myfile.readline
e_date = myfile.readline
e_time = myfile.readline
e_body = myfile.readline

myfile.close

puts e_from
puts e_subject
puts e_date
puts e_time
puts e_body


evs = Object::Foodevent.new(
	:from => e_from,
	:subject => e_subject,
	:date => e_date,
	:time => e_time,
	:body => e_body
)
evs.save
