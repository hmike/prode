class RemoveAvatarFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :avatar
  end
end
