class UserGroupMember < ActiveRecord::Base

	validates :user_group_id, presence: true
	validates :user_id, presence: true
	validates :user_group_id, :uniqueness => {:scope => :user_id, :message => 'El usuario ya pertene al grupo'}
	
	belongs_to :user
	belongs_to :user_group
	has_many :bets

	def score
    	get_score
	end

	def get_score
		scored_bets = bets.joins(:match).where("matches.date <= ?", Date.today.to_time.beginning_of_day)#@todo: hmike: get the end date of the match (or an status ::END::)
		score = 0
		scored_bets.each do |bet|
			score += bet.score
		end
		return score
		# bets.count
	end

end