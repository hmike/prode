class ChangeBirthdayFromUser < ActiveRecord::Migration
  def change
  	rename_column :users, :birthday, :birthdate
  end
end
