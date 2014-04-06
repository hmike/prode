class Bet < ActiveRecord::Base

	validates :user_group_member_id, presence: true
	validates :match_id, presence: true
	# validates :bet, presence: true

	belongs_to :user_group_member
	belongs_to :match

	def get_score
		bet_win = false
		if match.is_local_win
			bet_win = (bet == 1)
		elsif match.is_away_win
			bet_win = (bet == 2)
		elsif match.is_tie
			bet_win = (bet == 0)
		end

		bet_win ? 1:0
	end

end
