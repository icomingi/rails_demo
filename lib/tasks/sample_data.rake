require 'faker'

namespace :db do
	desc "Fill fake route_record"
	task :populate => :environment do
		User.all(:limit => 6).each do |user|
			1.times do
				user.route_records.create!(:from => "point A", :to => "point B")
			end
		end
	end
end
