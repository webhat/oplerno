# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


AdminUser.create! :email => 'crompton@oplerno.com', :password => ENV["MY_DEV_PASSWORD"], :password_confirmation => ENV["MY_DEV_PASSWORD"]
Teacher.create! :email => 'crompton@oplerno.com', :password => ENV["MY_DEV_PASSWORD"], :password_confirmation => ENV["MY_DEV_PASSWORD"], :confirmed_at => Time.now, :first_name => 'Daniel', :last_name => 'Crompton'
# Course.create! :name => 'Physics 101', :price => 1000, :teacher => '1'
# Course.create! :name => 'Advanced Physics', :price => 500, :teacher => '1'


# Populate DB
# 100.times { FactoryGirl.create(:course) }
