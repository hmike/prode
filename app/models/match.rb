class Match < ActiveRecord::Base

	validates :league_id, presence: true
	validates :date, presence: true
	validates :local_team_id, presence: true
	validates :away_team_id, presence: true
	#validates :local_score, presence: true, :numericality => { :only_integer => true }
	#validates :away_score, presence: true, :numericality => { :only_integer => true }
	validates :league_date, presence: true, :numericality => { :only_integer => true }
	#validates :is_playoff, presence: true

	belongs_to :league
	belongs_to :local_team, :class_name => 'Team'
	belongs_to :away_team, :class_name => 'Team'
	has_many :bets

end
