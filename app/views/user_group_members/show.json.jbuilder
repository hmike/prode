json.extract! @user_group_member, :id, :user_group_id, :user_id, :status, :created_at, :updated_at
json.user @user_group_member.user, :id, :email
# json.my_bets @bets, :id, :bet
# json.bets @bets do |bet|
# json.bet @my_bets
json.bets @bets do |bet|
	json.extract! bet, :id, :user_group_member_id, :match_id, :bet, :created_at, :updated_at
	# json.user member.user, :id, :email
	# json.user user_group_member_url(member, format: :json)
	# json.user member.user, :id, :email
	# json.url user_group_member_url(user_group_member, format: :json)
	# json.user user_group_member.user, :id, :email
end