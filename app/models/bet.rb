class Bet < ActiveRecord::Base

	validates :user_group_member_id, presence: true
	validates :match_id, presence: true
	# validates :bet, presence: true

	belongs_to :user_group_member
	belongs_to :match

end
