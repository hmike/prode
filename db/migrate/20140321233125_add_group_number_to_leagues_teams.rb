class AddGroupNumberToLeaguesTeams < ActiveRecord::Migration
  def change
    add_column :leagues_teams, :group_number, :char
  end
end
