class LeaguesTeams < ActiveRecord::Base

	validates :league_id, presence: :true
	validates :team_id, presence: true

	belongs_to :league
	belongs_to :team
	
end
