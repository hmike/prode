class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :code
      t.string :country
      t.string :avatar

      t.timestamps
    end
  end
end
