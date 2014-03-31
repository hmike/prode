json.array!(@user_groups) do |user_group|
	json.extract! user_group, :id, :user_id, :name
	json.user user_group.user, :email
	json.league user_group.league, :name
	# json.members user_group.user_group_members.user
	json.members user_group.user_group_members do |member|
		json.extract! member, :id, :user_group_id, :user_id, :status
		json.user member.user, :id, :email
		# json.user user_group_member_url(member, format: :json)
		# json.user member.user, :id, :email
		# json.url user_group_member_url(user_group_member, format: :json)
		# json.user user_group_member.user, :id, :email
	end
	json.url user_group_url(user_group, format: :json)
end