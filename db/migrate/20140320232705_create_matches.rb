class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :league_id
      t.datetime :date
      t.integer :local_team_id
      t.integer :away_team_id
      t.integer :local_score
      t.integer :away_score
      t.integer :league_date

      t.timestamps
    end
  end
end
