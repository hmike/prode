class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_group_member_id
      t.integer :match_id
      t.integer :bet

      t.timestamps
    end
  end
end
