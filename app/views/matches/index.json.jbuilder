json.array!(@matches) do |match|
  json.extract! match, :id, :league_id, :date, :local_team_id, :away_team_id, :local_score, :away_score, :league_date
  json.local_team match.local_team
  json.away_team match.away_team
  json.bets match.bets[0]
  json.url match_url(match, format: :json)
end

	# json.array!(@user_groups) do |user_group|
	# 	json.extract! user_group, :id, :user_id, :name
	# 	json.user user_group.user, :email
	# 	# json.members user_group.user_group_members.user
	# 	json.members user_group.user_group_members do |member|
	# 		json.extract! member, :id, :user_group_id, :user_id, :status
	# 		json.user member.user, :id, :email
	# 		# json.user user_group_member_url(member, format: :json)
	# 		# json.user member.user, :id, :email
	# 		# json.url user_group_member_url(user_group_member, format: :json)
	# 		# json.user user_group_member.user, :id, :email
	# 	end
	# 	json.url user_group_url(user_group, format: :json)
	# end