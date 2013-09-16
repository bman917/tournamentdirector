require 'csv'

namespace :tournament do
	desc "Sets correct PBC Averags based on hard coded rules"
	task :pbc_average => :environment do

	puts "Updating PBC averages..."
		Bowler.all.each do |bowler|
			bowler.update_pbc_classification

			puts "Missing PBC Classification for #{bowler.name} - #{bowler.latest_average}" unless bowler.pbc_classification
		end
	end


	task :pbc_import => :environment do

		CSV.foreach("#{Rails.root}/db/seeds/1st Quarter Average 2012 (MEN)_edited.csv", headers:true) do | row|
			names = row[0].split(',')
			fname = names[1].strip if names[1]
			lname = names[0].strip if names[0]
			association = row[1] 
			average = row[2]
			total_pinfalls = row[3]
			games_played = row[4]

			fname ||= '-'
			lname ||= '-'

			association = 'unattached' unless association
			association = 'unattached' if association && association.strip.size == 0

			#puts "xxxxxxxxx #{names} ass - [#{association}] #{association.size}"
			ass = BowlingAssociation.find_or_create_by(name: association)

			#puts "[#{fname}, #{lname}] ASS[#{ass}] AVE[#{average}]]"

			bowler = Bowler.where(name: fname, last_name: lname).first_or_create
			bowler.bowling_association = ass
			#puts "Bowler: #{bowler.id}"
			bowler.save!

			bowler.average_entries.destroy

			bowler.average_entries.create(average: average, average_type: 'PBC', total_pinfalls: total_pinfalls, games_played: games_played, user_id: 0)
		end
	end

	task :pbc_import_ladies => :environment do

		CSV.foreach("#{Rails.root}/db/seeds/1st Quarter Average 2012 (LADIES).csv", headers:true) do | row|
			names = row[0].split(',')
			fname = names[1].strip if names[1]
			lname = names[0].strip if names[0]
			association = row[1] 
			average = row[2]
			total_pinfalls = row[3]
			games_played = row[4]

			fname ||= '-'
			lname ||= '-'

			association = 'unattached' unless association
			association = 'unattached' if association && association.strip.size == 0

			#puts "xxxxxxxxx #{names} ass - [#{association}] #{association.size}"
			ass = BowlingAssociation.find_or_create_by(name: association)

			#puts "[#{fname}, #{lname}] ASS[#{ass}] AVE[#{average}]]"

			bowler = Bowler.where(name: fname, last_name: lname).first_or_create
			bowler.bowling_association = ass
			bowler.gender = 'F'
			bowler.save!

			bowler.average_entries.destroy

			bowler.average_entries.create(average: average, average_type: 'PBC', total_pinfalls: total_pinfalls, games_played: games_played)

			puts "Saved Bowler: #{bowler}"


		end
	end
end