namespace :tournament do
	desc "Sets correct PBC Averags based on hard coded rules"
	task :pbc_average => :environment do

	puts "Updating PBC averages..."
		Bowler.all.each do |bowler|
			bowler.update_pbc_classification

			puts "Missing PBC Classification for #{bowler.name} - #{bowler.latest_average}" unless bowler.pbc_classification
		end
	end
end