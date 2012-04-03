# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Page.create(:name => "home", :body => "Home Page Content", :published => true, :status => 0, :title => "Home Page")
Page.create(:name => "about", :body => "Home Page Content", :published => true, :status => 0, :title => "About Us")
Page.create(:name => "contact", :body => "Home Page Content", :published => true, :status => 0, :title => "Contact")
Page.create(:name => "support", :body => "Home Page Content", :published => true, :status => 0, :title => "Support")
