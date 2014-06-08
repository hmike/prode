json.array! @user_group_members do |user_group_member|
	json.extract! user_group_member.user_group, :id, :user_id, :name
	json.user user_group_member.user_group.user, :email
	json.league user_group_member.user_group.league, :name, :avatar_thumb_url	

	json.members user_group_member.user_group.user_group_members do |member|
		json.extract! member, :id, :user_group_id, :user_id, :status
		json.user member.user, :id, :email
	end
	json.url user_group_url(user_group_member.user_group, format: :json)
end