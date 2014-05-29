class Bet < ActiveRecord::Base

	validates :user_group_member_id, presence: true
	validates :match_id, presence: true
	# validates :bet, presence: true

	belongs_to :user_group_member
	belongs_to :match

	def win
		bet_win = false
		if match.is_local_win
			bet_win = (bet == 1)
		elsif match.is_away_win
			bet_win = (bet == 2)
		elsif match.is_tie
			bet_win = (bet == 0)
		end
		return bet_win
	end

	def score
		win ? 1:0
	end

	def bet_label
		case bet
		when 0
			'empate'
		when 1
			'local'
		when 2
			'visitante'
		end
	end

end
