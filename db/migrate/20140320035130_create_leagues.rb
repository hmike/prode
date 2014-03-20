class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.string :league_type
      t.integer :groups_count
      t.integer :teams_count

      t.timestamps
    end
  end
end
