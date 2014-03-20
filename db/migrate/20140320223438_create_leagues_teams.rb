class CreateLeaguesTeams < ActiveRecord::Migration
  def change
    create_table :leagues_teams do |t|
      t.integer :league_id
      t.integer :team_id

      t.timestamps
    end
  end
end
