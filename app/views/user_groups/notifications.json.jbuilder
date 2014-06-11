json.array!(@notifications) do |user_group_member|
  json.extract! user_group_member, :id, :user_group_id, :user_id, :status
  json.user_group user_group_member.user_group, :id, :name
  json.url user_group_member_url(user_group_member, format: :json)
end