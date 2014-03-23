class AddMatchesFieldsToLeaguesTeams < ActiveRecord::Migration
  def change
	add_column :leagues_teams, :points, :integer
    add_column :leagues_teams, :matches_played, :integer
    add_column :leagues_teams, :matches_won, :integer
    add_column :leagues_teams, :matches_lost, :integer
    add_column :leagues_teams, :matches_tied, :integer
    add_column :leagues_teams, :goals_scored, :integer
    add_column :leagues_teams, :goals_against, :integer
  end
end
