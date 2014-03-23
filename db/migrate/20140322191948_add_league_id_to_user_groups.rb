class AddLeagueIdToUserGroups < ActiveRecord::Migration
  def change
    add_column :user_groups, :league_id, :integer
  end
end
