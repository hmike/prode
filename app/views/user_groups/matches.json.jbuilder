# json.extract! @matches, :id
# json.user @user_group_member.user, :id, :email
# # json.my_bets @bets, :id, :bet
# # json.bets @bets do |bet|
# # json.bet @my_bets
json.array! @matches do |match|
	json.extract! match, :id, :date, :local_team, :away_team, :local_score, :away_score, :league_date, :is_playoff, :is_expired
	# json.user member.user, :id, :email
	# json.user user_group_member_url(member, format: :json)
	# json.user member.user, :id, :email
	# json.url user_group_member_url(user_group_member, format: :json)
	# json.user user_group_member.user, :id, :email
end