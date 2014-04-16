require 'csv'

desc "Import models from csv file"

task :import_leagues => [:environment] do

	file = "db/leagues.csv"

	CSV.foreach(file, :headers => true) do |row|
		puts 'Importing League ' + row[1]
		# id,name,league_type,groups_count,teams_count,avatar
	    league = League.where(:name => row[1]).first || League.new
	    league.assign_attributes({
			:name => row[1],
			:league_type => row[2],
			:groups_count => row[3],
			:teams_count => row[4],
			:avatar => row[5],
		})
		league.save
	end 
end

task :import_teams, [:file] => :environment do |task, args|

	# file = "db/matches_final2014.csv"
	# file = "db/teams.csv"
	file = args[:file]

	CSV.foreach(file, :headers => true) do |row|
		# puts 'Importing Team ' + row[2]
		puts "Importing Team #{row[2]}"
		# id,code,name,country,league,avatar,group_number
	    # team = Team.where(:code => row[1]).first || Team.new
	    team = Team.where(:name => row[2]).first || Team.new
	    team.assign_attributes({
			:code => row[1],
			:name => row[2],
			:country => row[3],
			:avatar => row[5],
		})
		# team.leagues << League.where(:name => row[4]).first
		team.save

		league = League.where(:name => row[4]).first
		league_team = LeaguesTeams.where(:league => league, :team => team).first || LeaguesTeams.new
		league_team.assign_attributes({
			:league => league,
			:team => team,
			:group_number => row[6],
		})
		league_team.save
	end 
end

task :import_matches, [:file] => :environment do |task, args|

	# file = "db/matches_final2014.csv"
	file = args[:file]

	CSV.foreach(file, :headers => true) do |row|
		puts 'Importing Match ' + row[7] + ': ' + row[3] + ' VS ' + row[4]
		# id,league,date,local_team,away_team,local_score,away_score,league_date,is_playoff,stadium,referee,Local,goles_local,goles_visitante,Visitante,Estado,Estadio,Arbitro,ficha
		league = League.where(:name => row[1]).first
		# local_team = Team.where(:code => row[3]).first
		# away_team = Team.where(:code => row[4]).first

		local_team = Team.where(:name => row[14]).first
		away_team = Team.where(:name => row[15]).first

		match = Match.where(
						:league_id => league.id,
						:local_team_id => local_team.id,
						:away_team_id => away_team.id,
						:league_date => row[7]
					).first || Match.new
		match.assign_attributes({
			:league_id => league.id,
			:date => row[2],
			:local_team_id => local_team.id,
			:away_team_id => away_team.id,
			:local_score => row[5],
			:away_score => row[6],
			:league_date => row[7],
			:is_playoff => row[8],
		})
		match.save
	end 
end
