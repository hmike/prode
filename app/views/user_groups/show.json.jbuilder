json.extract! @user_group, :id, :user_id, :name, :created_at, :updated_at
json.league @user_group.league, :id, :name, :groups_count, :teams_count, :dates_count