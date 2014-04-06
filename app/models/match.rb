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

	def was_played
		(local_score != nil && away_score != nil)
	end

	def is_local_win
		#@todo: hmike: handle this error case
		if !was_played
			return nil
		end

		(local_score > away_score)
	end

	def is_away_win
		#@todo: hmike: handle this error case
		if !was_played
			return nil
		end

		(local_score < away_score)
	end

	def is_tie
		#@todo: hmike: handle this error case
		if !was_played
			return nil
		end

		(local_score == away_score)
	end

end
