namespace :db do
	desc "Fill database with sample data"
  	task :populate => :environment do
    	Rake::Task['db:reset'].invoke
    	make_users
    	make_considerations
    	make_votes
  	end
end

def make_users
    admin = User.create!(:name => "Example User")
    admin.toggle!(:admin)
  	50.times do |n|
    	name  = Faker::Name.name
    	User.create!(:name => name)
  	end
end

def make_considerations
  	User.all(:limit => 6).each do |user|
    	50.times do
      		content = Faker::Lorem.sentence(5)
      		user.considerations.create!(:content => content)
    	end
  	end
end

def make_votes
  	users = User.all
  	user  = users.first
  	considerations - Consideration.all
  	consideration = considerations.first
  	voteds = considerations[1..50]
  	voters = users[3..40]
  	voteds.each { |voted| user.vote!(voted) }
  	voters.each { |voter| voter.vote!(voted) }
end

namespace :db do
	desc "Remove sample data from database"
  	task :unpopulate => :environment do
    	Rake::Task['db:reset'].invoke
    end
end