json.extract! @user_group_member, :id, :user_group_id, :user_id, :status, :created_at, :updated_at
json.user @user_group_member.user, :id, :email